class ParametrizedDriverLocationModel {
  String? latitude;
  String? longitude;

  ParametrizedDriverLocationModel({
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
