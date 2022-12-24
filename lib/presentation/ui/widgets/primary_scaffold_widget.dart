import 'package:flutter/material.dart';
import '../../../services/constants/app_styles.dart';

class PrimaryScaffoldWidget extends StatelessWidget {
  final String titleText;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const PrimaryScaffoldWidget({
    Key? key,
    required this.titleText,
    required this.child,
    this.actions,
    this.floatingActionButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        title: Text(titleText),
        actions: actions,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
          child: child,
        ),
      )
    );
  }
}
