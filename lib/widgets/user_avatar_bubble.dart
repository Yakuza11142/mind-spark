import 'package:flutter/material.dart';

class UserAvatarBubble extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final VoidCallback? onTap;

  const UserAvatarBubble({
    Key? key,
    required this.imageUrl,
    this.radius = 24.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.indigo.shade800,
        backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
        child: imageUrl.isEmpty
            ? const Icon(Icons.person_rounded, color: Colors.white)
            : null,
      ),
    );
  }
}
