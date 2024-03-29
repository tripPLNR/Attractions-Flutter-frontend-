import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBlurBackground extends StatelessWidget {
  final Widget child;

  const CustomBlurBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
        // ),
        // Blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            color: Colors.transparent, // Make sure to keep it transparent
          ),
        ),
        // Your original child (e.g., an image, another container, etc.)
        child,
        // Black overlay with opacity
      ],
    );
  }
}
