import 'package:flutter/material.dart';

class AppBarBuilder extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;

  const AppBarBuilder({Key? key, required this.titleText, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0F172A),
      elevation: 0,
      title: Text(
        titleText,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      actions: actions,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
