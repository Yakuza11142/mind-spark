import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendPressed;

  const ChatInputField({Key? key, required this.controller, required this.onSendPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xFF0F172A),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Ask Mind Spark Elite...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded, color: Colors.amber),
            onPressed: onSendPressed,
          ),
        ],
      ),
    );
  }
}
