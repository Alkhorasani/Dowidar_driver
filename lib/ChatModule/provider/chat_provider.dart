import 'dart:io';

import 'package:dowidardriver/ServiceLayer/Sl_Chat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../MVVM/Model/ModChat/send_message_model.dart';

class ChatProvider extends ChangeNotifier {
  bool isSendingMessage = false;
  String messageText = '';
  final ref = FirebaseDatabase.instance.ref();

  String chatStatus = "-1";

  String getSortedId(String value, String value1, String value2) {
    int result = value1.compareTo(value2);

    if (result < 0) {
      print('${value}_${value1}_$value2');
      return '${value}_${value1}_$value2';
    } else if (result > 0) {
      print('${value}_${value2}_$value1');
      return '${value}_${value2}_$value1';
    } else {
      print('${value}_${value1}_$value2');

      return '${value}_${value1}_$value2';
    }
  }

  Future sendAttachmentMessage(
      String senderId, List<String> receiverId, List<File>? files, String message, String orderId) async {
    isSendingMessage = true;
    notifyListeners();

    final l_SharedPreferences = await SharedPreferences.getInstance();

    final accessToken = await l_SharedPreferences.getString('l_token') ?? '';

    SendMessageRequest fields =
        SendMessageRequest(orderId: orderId, senderId: senderId, receiverId: receiverId, message: message);
    print(fields.toJson());
    List<String> filePaths = [];
    if (files != null && files.isNotEmpty) {
      for (var file in files) {
        filePaths.add(file.path);
      }
    }
    print(filePaths);
    try {
      dynamic postResponse = await Sl_Chat().sendChatMessage(fields.toJson(), filePaths, accessToken);

      print(postResponse);

      isSendingMessage = false;
      notifyListeners();
      return postResponse;
    } catch (e, stack) {
      print(e);
      print(stack);
      isSendingMessage = false;
      notifyListeners();
      return '';
    }
  }
}
