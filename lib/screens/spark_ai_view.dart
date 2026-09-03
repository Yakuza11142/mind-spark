import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SparkAIView extends StatefulWidget {
  const SparkAIView({super.key});

  @override
  State<SparkAIView> createState() => _SparkAIViewState();
}

class _SparkAIViewState extends State<SparkAIView> with TickerProviderStateMixin {
  final TextEditingController _omniController = TextEditingController();
  String _activePromptToken = '';

  Offset _panOffset = Offset.zero;
  bool _hasGenerated = false;

  // 🎛️ Mode Configuration State Selector
  bool _isAetherLiveMode = false; 

  late final AnimationController _pulseController;
  late final AnimationController _liveWaveController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _liveWaveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
  }

  @override
  void dispose() {
    _omniController.dispose();
    _pulseController.dispose();
    _liveWaveController.dispose();
    super.dispose();
  }

  // =========================================================
  // ⚡ MULTIMODAL CANVAS GENERATION SYNTHESIS
  // =========================================================
  void _triggerMultimodalSynthesis(ThemeData theme) {
    final text = _omniController.text.trim();
    if (text.isEmpty) return;

    HapticFeedback.selectionClick();

    setState(() {
      _activePromptToken = text;
      _hasGenerated = true;
      _omniController.clear();
    });

    _synthesizeVoiceResponse('${theme.primaryColor} $text');
  }

  // =========================================================
  // 🎙️ "AETHER LIVE" VOICE ENGINE TRANSITION DIRECTIVES
  // =========================================================
  void _toggleAetherLiveVoiceCore(bool selectLive, ThemeData theme) {
    HapticFeedback.mediumImpact();
    setState(() {
      _isAetherLiveMode = selectLive;
      if (_isAetherLiveMode) {
        _liveWaveController.repeat(reverse: true);
        _synthesizeVoiceResponse(theme.colorScheme.secondary.toString());
      } else {
        _liveWaveController.stop();
        const MethodChannel('flutter/accessibility').invokeMethod('cancel'); 
      }
    });
  }

  void _synthesizeVoiceResponse(String speechText) {
    try {
      const MethodChannel('flutter/accessibility').invokeMethod(
        'announce',
        {'message': speechText},
      );
    } catch (_) {}
  }

  void _exportProceduralFile(ThemeData theme) {
    HapticFeedback.vibrate();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: theme.colorScheme.primary,
        content: Text(theme.platform.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final double canvasWidth = mediaQuery.size.width;
    final double canvasHeight = mediaQuery.size.height;

    // Fixed: Safely resolve fontFamily string without relying on uninitialized typography styles
    final String fallbackFontName = theme.textTheme.bodyLarge?.fontFamily ?? 'Text Core';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🌐 THE ORGANIC SANDBOX VIEWPORT
          GestureDetector(
            onPanUpdate: (details) {
              if (!_isAetherLiveMode) {
                setState(() {
                  _panOffset += details.delta; 
                });
              }
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: AnimatedBuilder(
                animation: Listenable.merge([_pulseController, _liveWaveController]),
                builder: (context, _) {
                  return CustomPaint(
                    painter: OmniSynthesisPainter(
                      panOffset: _panOffset,
                      pulseValue: _pulseController.value,
                      liveWaveValue: _liveWaveController.value,
                      hasGenerated: _hasGenerated,
                      isLiveActive: _isAetherLiveMode,
                      themeColor: theme.colorScheme.primary,
                      accentColor: theme.colorScheme.secondary,
                      canvasBg: theme.scaffoldBackgroundColor,
                    ),
                  );
                },
              ),
            ),
          ),

          // 👁️ MODE A: DYNAMIC MULTIMODAL CANVAS MEDIA CARD BLOCKS
          if (_hasGenerated && !_isAetherLiveMode) ...[
            // Text Core Box
            Positioned(
              left: (canvasWidth * 0.05) + _panOffset.dx,
              top: (canvasHeight * 0.12) + _panOffset.dy,
              child: _buildOmniCard(
                theme, mediaQuery, widthRatio: 0.38, title: fallbackFontName,
                child: Text(_activePromptToken, style: TextStyle(color: theme.textTheme.bodyMedium?.color, fontSize: 11)),
              ),
            ),

            // Image Core Box
            Positioned(
              left: (canvasWidth * 0.55) + _panOffset.dx,
              top: (canvasHeight * 0.10) + _panOffset.dy,
              child: _buildOmniCard(
                theme, mediaQuery, widthRatio: 0.40, title: 'Image Synthesis',
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: CustomPaint(painter: CanvasMicroImagePainter(themeColor: theme.colorScheme.primary)),
                ),
              ),
            ),

            // Video Core Box
            Positioned(
              left: (canvasWidth * 0.05) + _panOffset.dx,
              top: (canvasHeight * 0.40) + _panOffset.dy,
              child: _buildOmniCard(
                theme, mediaQuery, widthRatio: 0.40, title: 'Live Stream Core',
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: CustomPaint(painter: LiveStreamMotionPainter(pulse: _pulseController.value, themeColor: theme.colorScheme.secondary, canvasBg: theme.scaffoldBackgroundColor)),
                ),
              ),
            ),

            // 3D Geometry Object Exporter Core Box
            Positioned(
              left: (canvasWidth * 0.52) + _panOffset.dx,
              top: (canvasHeight * 0.38) + _panOffset.dy,
              child: _buildOmniCard(
                theme, mediaQuery, widthRatio: 0.43, title: '3D Geometry Exporter',
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: CustomPaint(
                        painter: Axonometric3DVectorPainter(pulse: _pulseController.value, themeColor: theme.colorScheme.primary),
                      ),
                    ),
                    SizedBox(height: mediaQuery.size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            textStyle: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => _exportProceduralFile(theme),
                          child: const Text('Export OBJ'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            textStyle: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => _exportProceduralFile(theme),
                          child: const Text('Export FBX'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],

          // 🗣️ MODE B: "AETHER LIVE" INTERACTIVE VOICED OVERLAY VIEW
          if (_isAetherLiveMode)
            Center(
              child: Padding(
                padding: EdgeInsets.all(mediaQuery.size.width * 0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _activePromptToken.toUpperCase(),
                      style: TextStyle(color: theme.colorScheme.secondary, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 2.0),
                    ),
                    SizedBox(height: mediaQuery.size.height * 0.01),
                    Text(
                      'Aether Live Voice Core Active',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: theme.hintColor, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),

          // 📥 LOWER PLATFORM CONTROL INTEGRATION DECK
          Positioned(
            left: canvasWidth * 0.04,
            right: canvasWidth * 0.04,
            bottom: canvasHeight * 0.02,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🎛️ INLINE MODE CHOICE SEGMENTED CONTROL BAR
                Container(
                  margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.015),
                  padding: EdgeInsets.all(mediaQuery.size.height * 0.005),
                  decoration: BoxDecoration(
                    color: theme.cardColor.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildModeSelectionTab(
                        label: 'Canvas', 
                        icon: Icons.dashboard_customize_outlined,
                        isActive: !_isAetherLiveMode, 
                        theme: theme, 
                        mediaQuery: mediaQuery,
                        onTap: () => _toggleAetherLiveVoiceCore(false, theme),
                      ),
                      _buildModeSelectionTab(
                        label: 'Live', 
                        icon: Icons.record_voice_over_outlined,
                        isActive: _isAetherLiveMode, 
                        theme: theme, 
                        mediaQuery: mediaQuery,
                        onTap: () => _toggleAetherLiveVoiceCore(true, theme),
                      ),
                    ],
                  ),
                ),
                // TEXT FIELD INPUT AREA
                Container(
                  padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.04, vertical: mediaQuery.size.height * 0.005),
                  decoration: BoxDecoration(
                    color: theme.cardColor.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _omniController,
                          enabled: !_isAetherLiveMode,
                          style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                          decoration: InputDecoration(
                            hintText: 'Enter prompt or instruction...',
                            hintStyle: TextStyle(color: theme.hintColor, fontSize: 13),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _triggerMultimodalSynthesis(theme),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.all_inclusive_rounded, color: _isAetherLiveMode ? theme.hintColor : theme.colorScheme.secondary),
                        onPressed: _isAetherLiveMode ? null : () => _triggerMultimodalSynthesis(theme),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelectionTab({
    required String label, 
    required IconData icon, 
    required bool isActive, 
    required ThemeData theme, 
    required MediaQueryData mediaQuery, 
    required VoidCallback onTap
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.035, vertical: mediaQuery.size.height * 0.008),
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isActive ? theme.colorScheme.onPrimary : theme.hintColor),
            SizedBox(width: mediaQuery.size.width * 0.015),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isActive ? theme.colorScheme.onPrimary : theme.hintColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildOmniCard(ThemeData theme, MediaQueryData mediaQuery, {required double widthRatio, required String title, required Widget child}) {
    return Container(
      width: mediaQuery.size.width * widthRatio,
      padding: EdgeInsets.all(mediaQuery.size.width * 0.025),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.85), 
        borderRadius: BorderRadius.circular(16), 
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: theme.colorScheme.secondary, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          SizedBox(height: mediaQuery.size.height * 0.008),
          child,
        ],
      ),
    );
  }
}

class OmniSynthesisPainter extends CustomPainter {
  final Offset panOffset; 
  final double pulseValue; 
  final double liveWaveValue; 
  final bool hasGenerated; 
  final bool isLiveActive; 
  final Color themeColor; 
  final Color accentColor; 
  final Color canvasBg;

  OmniSynthesisPainter({
    required this.panOffset, 
    required this.pulseValue, 
    required this.liveWaveValue, 
    required this.hasGenerated, 
    required this.isLiveActive, 
    required this.themeColor, 
    required this.accentColor, 
    required this.canvasBg,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    final Offset coreAnchor = Offset(size.width / 2, size.height * 0.4) + panOffset;
    if (isLiveActive) {
      paint.style = PaintingStyle.stroke; 
      paint.strokeWidth = 1.5;
      for (int i = 0; i < 5; i++) {
        paint.color = accentColor.withOpacity(0.4 - (i * 0.07));
        final path = Path()..moveTo(0, size.height * 0.42);
        for (double x = 0; x <= size.width; x += 10) {
          double amplitude = 22.0 * liveWaveValue;
          double y = size.height * 0.42 + (amplitude * math.sin((x * 0.02) + (i * 0.5)));
          path.lineTo(x, y);
        }
        canvas.drawPath(path, paint);
      }
    } else {
      paint.style = PaintingStyle.stroke; 
      paint.strokeWidth = 0.5; 
      paint.color = themeColor.withOpacity(0.06 * (1.0 - pulseValue));
      canvas.drawCircle(coreAnchor, 40 + (pulseValue * 160), paint);
      if (hasGenerated) {
        paint.color = accentColor.withOpacity(0.2); 
        paint.strokeWidth = 0.75;
        canvas.drawLine(coreAnchor, coreAnchor + const Offset(-90, -160), paint);
        canvas.drawLine(coreAnchor, coreAnchor + const Offset(110, -180), paint);
        canvas.drawLine(coreAnchor, coreAnchor + const Offset(-70, 90), paint);
        canvas.drawLine(coreAnchor, coreAnchor + const Offset(100, 80), paint);
      }
    }
  }

  @override 
  bool shouldRepaint(covariant OmniSynthesisPainter oldDelegate) => true;
}

class CanvasMicroImagePainter extends CustomPainter {
  final Color themeColor; 
  CanvasMicroImagePainter({required this.themeColor});

  @override 
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = themeColor.withOpacity(0.2);
    final center = Offset(size.width / 2, size.height / 2); 
    canvas.drawCircle(center, 18, paint);
    canvas.drawRect(Rect.fromCenter(center: center, width: 30, height: 30), paint..style = PaintingStyle.stroke..color = themeColor);
  }

  @override 
  bool shouldRepaint(covariant CanvasMicroImagePainter oldDelegate) => false;
}

class LiveStreamMotionPainter extends CustomPainter {
  final double pulse; 
  final Color themeColor; 
  final Color canvasBg; 

  LiveStreamMotionPainter({required this.pulse, required this.themeColor, required this.canvasBg});

  @override 
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = canvasBg);
    final path = Path()..moveTo(0, size.height);
    for (double x = 0; x <= size.width; x += 4.0) {
      double y = size.height * 0.5 + (14 * math.sin((x * 0.04) + (pulse * 6.28))); 
      path.lineTo(x, y);
    }
    canvas.drawPath(path, Paint()..isAntiAlias = true..color = themeColor.withOpacity(0.35)..style = PaintingStyle.fill);
  }

  @override 
  bool shouldRepaint(covariant LiveStreamMotionPainter oldDelegate) => true;
}

class Axonometric3DVectorPainter extends CustomPainter {
  final double pulse; 
  final Color themeColor; 

  Axonometric3DVectorPainter({required this.pulse, required this.themeColor});

  @override 
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = themeColor;
    final double cx = size.width / 2; 
    final double cy = size.height / 2; 
    double o = 20.0 + (pulse * 8.0);
    Offset p1 = Offset(cx, cy - o); 
    Offset p2 = Offset(cx + (o * 1.73 / 2), cy - (o / 2)); 
    Offset p3 = Offset(cx + (o * 1.73 / 2), cy + (o / 2));
    Offset p4 = Offset(cx, cy + o); 
    Offset p5 = Offset(cx - (o * 1.73 / 2), cy + (o / 2)); 
    Offset p6 = Offset(cx - (o * 1.73 / 2), cy - (o / 2));
    canvas.drawLine(p1, p2, paint); 
    canvas.drawLine(p2, p3, paint); 
    canvas.drawLine(p3, p4, paint); 
    canvas.drawLine(p4, p5, paint); 
    canvas.drawLine(p5, p6, paint); 
    canvas.drawLine(p6, p1, paint);
    canvas.drawLine(Offset(cx, cy), p1, paint..color = themeColor.withOpacity(0.5)); 
    canvas.drawLine(Offset(cx, cy), p3, paint); 
    canvas.drawLine(Offset(cx, cy), p5, paint);
  }

  @override 
  bool shouldRepaint(covariant Axonometric3DVectorPainter oldDelegate) => true;
}
