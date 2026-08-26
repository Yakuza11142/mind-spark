import 'package:flutter/material.dart';

class BreadcrumbNavigation extends StatelessWidget {
  final List<String> paths;

  const BreadcrumbNavigation({Key? key, required this.paths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: paths.map((path) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(path, style: const TextStyle(color: Colors.amberAccent, fontSize: 12)),
            if (path != paths.last)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.chevron_right_rounded, size: 14, color: Colors.white54),
              ),
          ],
        );
      }).toList(),
    );
  }
}
