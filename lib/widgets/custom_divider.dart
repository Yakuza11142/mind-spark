import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.indigo.withOpacity(0.3),
      thickness: 1,
      height: 24,
    );
  }
}
