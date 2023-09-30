// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final ImageProvider<Object> image;

  const MenuItem({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: image,
          height: MediaQuery.sizeOf(context).height / 8, 
          width: MediaQuery.sizeOf(context).height / 8, 
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
