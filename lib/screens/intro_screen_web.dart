import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;
import 'dart:js_interop';

@JS('document.createElement')
external JSObject nativeCreateElement(JSString tagName);

class NativeWebIntroVideo extends StatefulWidget {
  const NativeWebIntroVideo({super.key});

  @override
  State<NativeWebIntroVideo> createState() => _NativeWebIntroVideoState();
}

class _NativeWebIntroVideoState extends State<NativeWebIntroVideo> {
  final String _viewId = 'html_intro_video_player';
  late JSObject _nativeVideoElement;

  @override
  void initState() {
    super.initState();

    _nativeVideoElement = nativeCreateElement('video'.toJS);
    final dynamic video = _nativeVideoElement;
    video.src = 'intro.mp4';
    video.style.border = 'none';
    video.style.width = '100%';
    video.style.height = '100%';
    video.style.objectFit = 'cover';
    video.loop = true;
    video.autoplay = true;
    video.muted = true;
    video.setAttribute('playsinline', 'true');

    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
      (int viewId) => _nativeVideoElement,
    );

    video.play();
  }

  @override
  void dispose() {
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
    return HtmlElementView(viewType: _viewId);
  }
}
