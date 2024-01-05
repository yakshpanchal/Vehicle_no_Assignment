class VehicleModel {
  VehicleModel({
    required this.vehicleno,
    required this.brand,
    required this.type,
    required this.fuel,
  });
  late String vehicleno;
  late String brand;
  late String type;
  late String fuel;

  // Convert json data to dart object.
  // Data come in Json format from firestore.
  VehicleModel.fromJson(Map<String, dynamic> json) {
    vehicleno = json['vehicleno'] ?? '';
    brand = json['brand'] ?? '';
    type = json['type'] ?? '';
    fuel= json['fuel'] ?? '';
  }

  // Convert dart object to json data.
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['vehicleno'] = vehicleno;
    _data['brand'] = brand;
    _data['type'] = type;
    _data['fuel'] = fuel;
    return _data;
  }
}