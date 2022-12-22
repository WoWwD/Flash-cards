import 'package:flutter/material.dart';
import '../../../services/constants/app_styles.dart';

class PrimaryScaffoldWidget extends StatelessWidget {
  final String titleText;
  final Widget child;

  const PrimaryScaffoldWidget({
    Key? key,
    required this.titleText,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleText)),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
          child: child,
        ),
      )
    );
  }
}
