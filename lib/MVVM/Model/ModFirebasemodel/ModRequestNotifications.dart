class ModRequestNotifications {
  String? device_token;
  String? deviceName;
  String? os;
  String? os_version;


  ModRequestNotifications({
    this.device_token,
    this.deviceName,
    this.os,
    this.os_version,
  });

  Map<String, dynamic> toJson() {
    return {
      'device_token': device_token,
      'device': deviceName,
      'os': os,
      'os_version': os_version,
    };
  }
}
