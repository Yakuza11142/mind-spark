import 'package:flutter/material.dart';

class ReviewStars extends StatelessWidget {
  final double rating;
  final double size;

  const ReviewStars({
    Key? key,
    required this.rating,
    this.size = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData icon;
        if (index < rating.floor()) {
          icon = Icons.star_rounded;
        } else if (index < rating) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_border_rounded;
        }
        return Icon(icon, color: Colors.amber, size: size);
      }),
    );
  }
}
