import 'package:flutter/material.dart';

class ProFeatureLock extends StatelessWidget {
  final Widget child;
  final bool isPro;
  final VoidCallback onLockedTap;

  const ProFeatureLock({
    Key? key,
    required this.child,
    required this.isPro,
    required this.onLockedTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPro) return child;

    return Stack(
      children: [
        AbsorbPointer(
          absorbing: true,
          child: ColorFiltered(
            colorFilter: const ColorFilter.matrix(<double>[
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0,      0,      0,      1, 0,
            ]),
            child: child,
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.black.withOpacity(0.35),
            child: InkWell(
              onTap: onLockedTap,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_rounded,
                      color: Colors.amber,
                      size: 32,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'PRO FEATURE',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
