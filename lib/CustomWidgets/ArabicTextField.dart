import 'package:flutter/material.dart';

class CustomRestaurantNameText extends StatelessWidget {
  final String restaurantName;

  const CustomRestaurantNameText({required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    return Text(
      restaurantName,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }
}
