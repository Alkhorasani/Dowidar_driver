class ParametrizedNewOrderModel {
  int? order_id;
  bool? is_accepted;

  ParametrizedNewOrderModel({
    this.order_id,
    this.is_accepted,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_id': order_id,
      'is_accepted': is_accepted,
    };
  }
}
