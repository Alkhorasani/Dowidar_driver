class ParametrizedOrderStatusModel {
  int? order_id;
  String? status;

  ParametrizedOrderStatusModel({
    this.order_id,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_id': order_id,
      'status': status,
    };
  }
}
