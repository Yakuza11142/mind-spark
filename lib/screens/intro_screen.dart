import 'package:flutter/material.dart';

// 🔄 CONDITIONAL IMPORT MATRIX: Directs compilation workflows based on platform drivers natively
import 'intro_screen_stub.dart' if (dart.library.js_interop) 'intro_screen_web.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 📺 NATIVE VIEW HOOK: Resolves to an HTML video player on Web, and a blank placeholder on Android
          const Positioned.fill(
            child: NativeWebIntroVideo(),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text(
                      "Mind Spark",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black54,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "AI TUTOR & AR LAB",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Spacer(),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        },
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 56),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
