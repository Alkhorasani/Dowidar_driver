
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ViewImageList extends StatelessWidget {

  const ViewImageList({super.key, required this.images});

  final List<Object?> images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.deepOrange,),
      body: SizedBox(
        height: 1,
        width: 1,
        child: ListView.separated(itemBuilder: (context,index){
          String updatedUrl = images[index].toString().replaceFirst(
              "/home/it_bitsclan/Cut-6TIUM-Backend/public/", '');
          return CachedNetworkImage(
            imageUrl: updatedUrl,
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        },itemCount: images.length, separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 8);
        },),
      ),
    );
  }
}
