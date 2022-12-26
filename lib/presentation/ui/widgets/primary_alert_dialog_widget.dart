import 'package:flutter/material.dart';

class PrimaryAlertDialog extends StatelessWidget {
  final String textTitle;
  final List<Widget> actions;
  final Widget? content;
  final double height;

  const PrimaryAlertDialog({
    Key? key,
    required this.textTitle,
    required this.actions,
    this.content,
    this.height = 100
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(textTitle),
      content: Container(
        alignment: Alignment.center,
        width: 200,
        height: content != null? height: 0,
        child: content
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: actions
        )
      ],
    );
  }
}
