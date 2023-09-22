import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  final String textData;
  const TextHeader({super.key, required this.textData});

  @override
  Widget build(BuildContext context) {
    return Text(
      textData,
      style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8),
    );
  }
}
