import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tanked/src/data/enums/dimensions.enum.dart';
import 'package:tanked/src/data/enums/pump_state.enum.dart';
import 'package:tanked/src/data/enums/water_flow_state.enum.dart';
import 'package:tanked/src/data/local_data_source/local_data_source.impl.dart';
import 'package:tanked/src/presentation/resources/colors.res.dart';
import 'package:tanked/src/routing/app_pages.dart';

class HomeController extends GetxController {
  final _userLocal = LocalDataSourceImpl();
  final _remoteDb = FirebaseDatabase.instance;

  //getter and setters for loading state
  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool v) => _loading(v);

  bool get pumpIsOn => pumpState.value == PumpState.on;

  final startPumpIsInProgress = false.obs;
  final stopPumpIsInProgress = false.obs;

  final pumpStatus = "".obs;
  final pumpState = PumpState.off.obs;

  final waterFlowState = WaterFlowState.off.obs;
  final waterFlowStatus = "".obs;

  final connectedToInternet = false.obs;

  final tankWaterLevel = 0.0.obs;

  final operateAutomatically = false.obs;

  String get modelNumber => _userLocal.getModelNumber() ?? "";

  Map<String, dynamic> get tankDimensions =>
      _userLocal.getTankDimensions() ?? <String, dynamic>{};

  double get heightOfTank =>
      (tankDimensions[TankDimension.height.name] as int).toDouble();

  @override
  void onInit() {
    super.onInit();
    checkForInternetConnection();
    fetchPumpStatus();
    fetchWaterFlowStatus();
    fetchTankDimensions();
    fetchWaterLevelStatus();
  }

  Future<void> startPump() async {
    try {
      startPumpIsInProgress.value = true;

      final ref = _remoteDb.ref("control");

      await ref.update({
        "solenoidState": 1,
      });

      showSimpleNotification(
        Text(
          "${pumpStatus.value} ${waterFlowStatus.value}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: dark,
          ),
        ),
        background: tankedGreen,
      );

      startPumpIsInProgress.value = false;
    } finally {
      startPumpIsInProgress.value = false;
    }
  }

  Future<void> stopPump() async {
    try {
      stopPumpIsInProgress.value = true;

      final ref = _remoteDb.ref("control");

      await ref.update({
        "solenoidState": 0,
      });

      showSimpleNotification(
        Text(
          "${pumpStatus.value} ${waterFlowStatus.value}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: dark,
          ),
        ),
        background: tankedGreen,
      );

      stopPumpIsInProgress.value = false;
    } finally {
      stopPumpIsInProgress.value = false;
    }
  }

  String showGreetings() {
    final timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Good morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good afternoon';
    } else if ((timeNow > 16) && (timeNow <= 20)) {
      return 'Good evening';
    } else {
      return 'Good night';
    }
  }

  Future<void> checkForInternetConnection() async {
    InternetConnectionChecker().onStatusChange.listen(
      (status) {
        final hasInternet = status == InternetConnectionStatus.connected;

        connectedToInternet.value = hasInternet;

        if (!connectedToInternet.value) {
          showSimpleNotification(
            Text(
              "Unable to access $modelNumber, No Internet Connection.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: dark,
              ),
            ),
            background: redColor,
            duration: const Duration(seconds: 10),
          );
        } else {
          showSimpleNotification(
            Text(
              "Connected to $modelNumber",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: dark,
              ),
            ),
            background: tankedGreen,
          );
        }
      },
    );
  }

  Future<void> fetchPumpStatus() async {
    final ref = _remoteDb.ref("control/solenoidState");

    // Get the Stream
    final stream = ref.onValue;

    // Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      if (event.snapshot.value! == 0) {
        pumpState.value = PumpState.off;
        pumpStatus.value = "Pump is offline";
      } else {
        pumpState.value = PumpState.on;
        pumpStatus.value = "Pump is online";
      }

      print(pumpState.value);
      print(pumpStatus.value);
    });
  }

  Future<void> fetchWaterFlowStatus() async {
    final ref = _remoteDb.ref("watermonitor/flowstate");

    // Get the Stream
    final stream = ref.onValue;

    // Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      print(event.snapshot.value);
      if (event.snapshot.value! == 0) {
        waterFlowState.value = WaterFlowState.off;
        waterFlowStatus.value = "and water is not flowing through the pipes";
      } else {
        waterFlowState.value = WaterFlowState.on;
        waterFlowStatus.value = "and water is flowing through the pipes";
      }

      print(waterFlowState.value);
      print(waterFlowStatus.value);
    });
  }

  Future<void> fetchWaterLevelStatus() async {
    final ref = _remoteDb.ref("watermonitor/waterlevel");

    // Get the Stream
    final stream = ref.onValue;

    // Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      print(event.snapshot.value);

      final waterLevel = event.snapshot.value! as num;
      print(waterLevel);
      if (!waterLevel.isNegative) {
        calculateDecimal(waterLevel.toDouble());
      }
    });
  }

  Future<void> fetchTankDimensions() async {
    final ref = _remoteDb.ref("config");

    // Get the data once
    final tankDimensions = await ref.once().then<Map<String, dynamic>>(
          (event) => Map<String, dynamic>.from(
            jsonDecode(jsonEncode(event.snapshot.value))
                as Map<String, dynamic>,
          ),
        );

    _userLocal.saveTankDimensions(<String, dynamic>{
      TankDimension.height.name: tankDimensions["max_height"],
      TankDimension.radius.name: tankDimensions["radius"],
      TankDimension.dim.name: tankDimensions["dim"],
    });
  }

  void calculateDecimal(double waterLevel) {
    try {
      const emptyTankPercent = 0.88;
      // const fullTankPercent = -0.1;

      const increment = -0.035;

      final tankHeight = emptyTankPercent + (increment * waterLevel);

      tankWaterLevel.value = tankHeight;
      print("tankWaterLevel == $tankWaterLevel");
    } catch (e, s) {
      print(e);
      log(e.toString(), stackTrace: s);
    }
  }

  Future<void> automaticallyControlPumpDependingOnWaterLevelState() async {
    //When it's full, switch pump off to avoid spillage
    //When it's low, switch pump on
  }

  Future<void> connectToAnotherSystem() async {
    try {
      //delete config data
      await Future.wait([
        _userLocal.deleteModelNumber(),
        _userLocal.deleteTankDimensions(),
        _userLocal.deleteWaterLevel(),
      ]);

      Get.offAllNamed(
        Routes.onboarding,
        arguments: 0,
      );
    } catch (e) {}
  }
}
