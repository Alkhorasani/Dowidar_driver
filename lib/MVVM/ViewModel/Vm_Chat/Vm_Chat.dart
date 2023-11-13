import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:dowidardriver/ServiceLayer/Sl_Chat.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/ModChat/chat_message_model.dart';
import '../../Model/ModChat/send_message_model.dart';


class VmChat extends GetxController {


  var isSendingMessage = false.obs;
  var messageText = ''.obs;
  final ref = FirebaseDatabase.instance.ref();

  var chatStatus = "-1".obs;
  List<ChatMessage> chatData = [];  // Add this property

  // Define senderId, receiverId, and orderId properties
  String? senderIdd ;
  String? receiverIdd;
  int? orderIdd;



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

  Future<void> sendAttachmentMessage(
      String senderId, List<String> receiverId, List<File>? files, String message, int orderId) async {

    senderIdd = cmGlobalVariables.pbDriberID!;
    orderIdd = cmGlobalVariables.pBOntapOrderId!;
    receiverIdd = cmGlobalVariables.pbUserID ;

    isSendingMessage.value = true;
    final l_SharedPreferences = await SharedPreferences.getInstance();
    final accessToken = l_SharedPreferences.getString('l_token') ?? '';
    SendMessageRequest fields = SendMessageRequest(
      orderId: orderId.toString(),
      senderId: senderId, receiverId: receiverId, message: message,
    );
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

      isSendingMessage.value = false;
      return postResponse;
    } catch (e, stack) {
      print(e);
      print(stack);
      isSendingMessage.value = false;
    }
  }
 }

