import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;
import 'dart:js_interop'; // ✅ CORE DART INTEROP: Built directly into the SDK, works on all versions of Flutter

// Safely bind to the browser's global window document object natively without packages
@JS('document.createElement')
external JSObject nativeCreateElement(JSString tagName);

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final String _viewId = 'html_intro_video_player';
  late JSObject _nativeVideoElement;

  @override
  void initState() {
    super.initState();

    // 🌐 1. Create a pure HTML5 Video element directly using native JS Interop macro bindings
    _nativeVideoElement = nativeCreateElement('video'.toJS);
    
    // Assign configuration values safely through standard dynamic property casting extensions
    final dynamic video = _nativeVideoElement;
    video.src = 'intro.mp4'; // Maps directly to your root-level bundled file asset path
    video.style.border = 'none';
    video.style.width = '100%';
    video.style.height = '100%';
    video.style.objectFit = 'cover'; // Forces the video to scale into a cover background crop
    video.loop = true;
    video.autoplay = true;
    video.muted = true; // 🔊 HTML5 BROWSER AUTOPLAY FIX: Volume explicitly hard-muted to instantly unlock autoplay rendering permissions!
    video.setAttribute('playsinline', 'true'); // Prevents iPhones from forcing fullscreen video takeovers

    // 🔧 2. Register the HTML element factory natively into Flutter's platform layout layer
    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
      (int viewId) => _nativeVideoElement,
    );

    // Trigger explicit media playback execution thread safely
    video.play();
  }

  @override
  void dispose() {
    // 🩹 Wipes out the active native video stream layout nodes to protect memory performance across views
    try {
      final dynamic video = _nativeVideoElement;
      video.pause();
      video.src = '';
      video.remove();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 📺 BROWSER NATIVE VIEW ENGINE: Draws your full-screen video with zero packages
          Positioned.fill(
            child: HtmlElementView(viewType: _viewId),
          ),

          // 🌌 Clean visual overlay scrim to ensure text legibility
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          // 🎛️ Interaction Layout Matrix Overlay
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
                    
                    // 🚀 Navigation routing interactive target trigger
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
                    const SizedBox(height: 16),

                    // 🔊 Interactive Unmute Control Link
                    CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.white),
                        onPressed: () {
                          // Toggles browser-level audio playback parameters natively upon explicit user click interaction
                          final dynamic video = _nativeVideoElement;
                          video.muted = !video.muted;
                        },
                      ),
                    ),
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
