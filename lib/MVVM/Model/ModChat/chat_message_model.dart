class ChatMessage {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateTime;
  final List<Object?>? attachments;

  ChatMessage({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    this.attachments
  });

  // Deserialize the chat message from a JSON map
  static ChatMessage fromJson(Object? json1) {
    Map json = json1 as Map;
    return ChatMessage(
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      message: json['message'] != null? json['message'] as String : "",
      dateTime: json['dateTime'] != null ? DateTime.parse(json['dateTime'] as String):DateTime.now(),
      attachments: json['attachments'] != null?json['attachments'] as List<Object?>: [],
    );
  }

  // Serialize the chat message to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
