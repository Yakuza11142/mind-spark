import 'package:flutter/material.dart';

class RegenerateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const RegenerateButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.purpleAccent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.purpleAccent),
            )
          : const Icon(Icons.refresh_rounded, color: Colors.purpleAccent),
      label: Text(isLoading ? 'Regenerating...' : 'Regenerate Response'),
    );
  }
}
