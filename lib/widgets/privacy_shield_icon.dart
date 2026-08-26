import 'package:flutter/material.dart';

class PrivacyShieldIcon extends StatelessWidget {
  final bool isSecure;
  final VoidCallback? onTap;

  const PrivacyShieldIcon({
    Key? key,
    this.isSecure = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSecure ? Colors.green.withOpacity(0.15) : Colors.orange.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(
            color: isSecure ? Colors.green : Colors.orange,
            width: 1.5,
          ),
        ),
        child: Icon(
          isSecure ? Icons.security_rounded : Icons.gpp_maybe_rounded,
          color: isSecure ? Colors.greenAccent : Colors.orangeAccent,
          size: 20,
        ),
      ),
    );
  }
}
