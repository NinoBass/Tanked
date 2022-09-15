abstract class LocalDataSource {
  bool hasConfiguredSystem();

  Future<void> saveTankDimensions(Map<String, dynamic> dimensions);

  Map<String, dynamic>? getTankDimensions();

  Future<void> deleteTankDimensions();

  Future<void> saveModelNumber(String modelNumber);

  String? getModelNumber();

  Future<void> deleteModelNumber();

  Future<void> saveWaterLevel(double waterLevel);

  double? getWaterLevel();

  Future<void> deleteWaterLevel();
}
