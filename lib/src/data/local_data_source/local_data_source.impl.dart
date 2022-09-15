import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const _tankDetailsKey = "TANK_DETAILS";
  static const _modelNumberKey = "MODEL_NUMBER";
  static const _waterLevelKey = "WATER_LEVEL";
  static final _storageBox = GetStorage();

  @override
  bool hasConfiguredSystem() {
    log("checking if system has been configured");
    return getTankDimensions()?.isNotEmpty ?? false;
  }

  @override
  Future<void> saveTankDimensions(Map<String, dynamic> dimensions) async {
    log("saved tank dimesions");
    await _storageBox.write(_tankDetailsKey, dimensions);
  }

  @override
  Map<String, dynamic>? getTankDimensions() {
    log("fetched tank dimesions");
    final dims = _storageBox.read<Map<String, dynamic>>(_tankDetailsKey) ??
        <String, dynamic>{};
    return dims;
  }

  @override
  Future<void> deleteTankDimensions() async {
    log("deleted tank dimensions");
    await _storageBox.remove(_tankDetailsKey);
  }

  @override
  Future<void> deleteModelNumber() async {
    log("deleted model number");
    await _storageBox.remove(_modelNumberKey);
  }

  @override
  String? getModelNumber() {
    log("fetched model number");
    final modelNumber = _storageBox.read(_modelNumberKey);
    return modelNumber as String?;
  }

  @override
  Future<void> saveModelNumber(String modelNumber) async {
    log("saved model number");
    await _storageBox.write(_modelNumberKey, modelNumber);
  }

  @override
  Future<void> deleteWaterLevel() async {
    log("deleted water level");
    await _storageBox.remove(_waterLevelKey);
  }

  @override
  double? getWaterLevel() {
    log("fetched water level");
    final waterLevel = _storageBox.read(_waterLevelKey);
    return waterLevel as double?;
  }

  @override
  Future<void> saveWaterLevel(double waterLevel) async {
    log("saved water level");
    await _storageBox.write(_waterLevelKey, waterLevel);
  }
}
