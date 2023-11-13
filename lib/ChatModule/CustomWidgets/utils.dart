import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package


class AppUtils{

  static void showSnackBar(context,message){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message),duration: const Duration(milliseconds: 1000)));
  }



  static String secondsToMinutes(int seconds) {
    Duration d = Duration(days: 0, hours: 0, minutes: 0, seconds: seconds);
    return d.toString().substring(2, 7);
  }

  static bool isImageUrl(String url) {
    final imageExtensions = ['.jpeg', '.jpg', '.png', '.gif'];

    final lowercaseUrl = url.toLowerCase();

    for (final extension in imageExtensions) {
      if (lowercaseUrl.endsWith(extension)) {
        return true; // It is an image URL
      }
    }

    return false; // Not an image URL
  }

  static isDocUrl(String url) {
    final imageExtensions = ['.docx','.doc','.xlsx','.xls','.pptx','.ppt','.pdf','.txt'];

    final lowercaseUrl = url.toLowerCase();

    for (final extension in imageExtensions) {
      if (lowercaseUrl.endsWith(extension)) {
        return extension; // It is an image URL
      }
    }

    return false; // Not an image URL
  }

  static String getTimeFromData(DateTime dateTime){
    String timeString = DateFormat('h:mm a').format(dateTime.toLocal());
    return "${formatTimeAgo(dateTime)} $timeString";
  }

  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      // Today
      return '';
    } else if (difference.inDays == 1) {
      // Yesterday
      return 'yesterday';
    } else {
      // Format as days ago
      return '${difference.inDays} days ago';
    }
  }

  static Widget showLoader(){
    return const Center(
        child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator()));
  }

}

