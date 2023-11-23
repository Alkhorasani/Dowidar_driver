class ParametrizedDriverStatusModel {
  String? id;
  String? status;

  ParametrizedDriverStatusModel({
    this.id,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
    };
  }
}
