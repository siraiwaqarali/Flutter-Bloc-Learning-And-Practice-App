import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const HomeButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(size.width, 48),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
