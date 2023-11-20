import 'dart:io';

class SendMessageRequest {
  String orderId;
  String senderId;
  List<String> receiverId;
  String message;

  SendMessageRequest({
    required this.orderId,
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  Map<String, String> toJson() => {
    "order_id": orderId,
    "sender_id": senderId,
    "receiver_id": List<String>.from(receiverId.map((x) => x)).toString(),
    "message": message,
  };
}
