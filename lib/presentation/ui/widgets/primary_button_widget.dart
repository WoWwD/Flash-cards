import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Size? size;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: size
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
