import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ViewModel/Vm_Chat/Vm_Chat.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final VmChat vmChat = Get.put(VmChat());

  @override
  void initState() {
    vmChat.senderIdd = cmGlobalVariables.pbDriberID!;
    vmChat.orderIdd = cmGlobalVariables.pBOntapOrderId!;
    vmChat.receiverIdd = cmGlobalVariables.pbDriberID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // When tapping anywhere on the screen, dismiss the keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat',                  style: GoogleFonts.ubuntu(
              textStyle: const TextStyle(
                  fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600, letterSpacing: .5)),
          ),
        ),
        body: Column(
          children: [
            Obx(() {
              if (vmChat.isSendingMessage.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: vmChat.chatData.length,
                  itemBuilder: (context, index) {
                    final message = vmChat.chatData[index];
                    return ChatMessage(
                      message: message.message,
                      isCurrentUser: message.senderId == vmChat.senderIdd,
                    );
                  },
                ),
              );
            }),
            ChatInputField(
              onSendMessage: (message) {
                vmChat.sendAttachmentMessage(
                  vmChat.senderIdd!,
                  [vmChat.receiverIdd!],
                  null,
                  message,
                  vmChat.orderIdd!,
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
