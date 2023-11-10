import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ViewModel/Vm_Chat/Vm_Chat.dart';

class ChatView extends StatelessWidget {
  final VmChat vmChat = Get.put(VmChat());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //when tap anywhere on screen keyboard dismiss
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (vmChat.isSendingMessage.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: vmChat.chatData.length,
                  itemBuilder: (context, index) {
                    final message = vmChat.chatData[index];
                    return ChatMessage(
                      message: message.message,
                      isCurrentUser: message.senderId == vmChat.senderId,
                    );
                  },
                );
              }),
            ),
            ChatInputField(
              onSendMessage: (message) {
                vmChat.sendAttachmentMessage(
                  vmChat.senderId,
                  [vmChat.receiverId], // Wrap the receiverId in a list
                  null,
                  message,
                  vmChat.orderId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  ChatMessage({required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatInputField extends StatefulWidget {
  final Function(String) onSendMessage;

  ChatInputField({required this.onSendMessage});

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(hintText: 'Type your message...'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              String message = _messageController.text;
              if (message.isNotEmpty) {
                widget.onSendMessage(message);
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
