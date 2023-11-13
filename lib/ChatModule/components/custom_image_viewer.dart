import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomImageViewer extends StatelessWidget {
  final String? url;
  CustomImageViewer({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(url!),
          )
      ),
    );
  }
}