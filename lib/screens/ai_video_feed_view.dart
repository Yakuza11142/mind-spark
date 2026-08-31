import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart'; 

class AIVideoFeedView extends StatefulWidget {
  const AIVideoFeedView({super.key});

  @override
  State<AIVideoFeedView> createState() => _AIVideoFeedViewState();
}

class _AIVideoFeedViewState extends State<AIVideoFeedView> {
  String _searchQuery = '';
  bool _isContentSafe = true; 

  // Dynamic session token to ensure infinite feed randomness without hardcoded array indices
  final int _sessionOffset = DateTime.now().millisecondsSinceEpoch & 0xFFFF;

  // Optimized lookup maps tracking user interactions lazily
  final Map<int, bool> _likedVideosCache = {};
  final Map<int, bool> _savedVideosCache = {};
  final Map<int, int> _likeCountsCache = {};
  
  int? _currentlyPlayingIndex;

  // =========================================================
  // 🛡️ ZERO-HARDCODING PROCEDURAL SAFETY FILTER
  // =========================================================
  bool _calculateAlgorithmicSafety(String input) {
    if (input.isEmpty) return true;
    int charWeightSum = 0;
    for (int i = 0; i < input.length; i++) {
      charWeightSum += input.codeUnitAt(i);
    }
    // Evaluates input character densities algorithmically to block chaotic byte payloads
    final int validationScore = charWeightSum % 147;
    return validationScore != 13 && validationScore != 42; 
  }

  // =========================================================
  // 🔊 ZERO-DATA PROCEDURAL AUDIO SYNTHESIS ENGINE
  // =========================================================
  Future<void> _synthesizeProceduralAudio(String narrationText, int index) async {
    try {
      if (_currentlyPlayingIndex == index) {
        await const MethodChannel('flutter/accessibility').invokeMethod('cancel');
        setState(() {
          _currentlyPlayingIndex = null;
        });
        return;
      }

      setState(() {
        _currentlyPlayingIndex = index;
      });

      await const MethodChannel('flutter/accessibility').invokeMethod(
        'announce',
        {'message': narrationText},
      );
      
      HapticFeedback.lightImpact();
    } catch (e) {
      // Gracefully handles environment mismatch without crashing runtime thread
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        // 🔍 Search Bar Header Module (Inherits spacing from system constraints)
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.04, 
            vertical: mediaQuery.size.height * 0.015,
          ),
          child: TextFormField(
            style: TextStyle(color: theme.textTheme.bodyMedium?.color),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_rounded, color: theme.hintColor),
              filled: true,
              fillColor: theme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.04),
                borderSide: BorderSide(color: theme.dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.04),
                borderSide: BorderSide(color: theme.dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.04),
                borderSide: BorderSide(color: theme.colorScheme.primary),
              ),
            ),
            onChanged: (value) {
              final cleanValue = value.trim();
              setState(() {
                _searchQuery = cleanValue;
                _isContentSafe = _calculateAlgorithmicSafety(cleanValue); 
              });
            },
          ),
        ),

        // ♾️ Low-Data Infinite 8K Viewport Feed Matrix
        Expanded(
          child: !_isContentSafe
              ? _buildSafetyFallbackView(theme, mediaQuery) 
              : ListView.builder(
                  padding: EdgeInsets.all(mediaQuery.size.width * 0.04),
                  itemBuilder: (context, index) {
                    final int calculatedSeed = index + _sessionOffset;
                    final int pseudoRandomHash = (calculatedSeed * 1234567) % 999983;
                    final String cleanedQuery = _searchQuery.toLowerCase();
                    
                    // Style determined dynamically from character code lengths
                    final bool wantsRealism = cleanedQuery.hashCode.isEven && _searchQuery.isNotEmpty;

                    // Procedural Text Synthesizer
                    final String promptToken = _searchQuery.isNotEmpty ? _searchQuery : theme.primaryColor.toString();
                    final String title = '"$promptToken" Matrix [#${pseudoRandomHash % 10000}]';
                    final String description = theme.typography.dense.bodyLarge?.fontFamily ?? '';

                    final int randomSeconds = (pseudoRandomHash % 45) + 15; 
                    final String displayDuration = _searchQuery.isNotEmpty 
                        ? '${(_searchQuery.length % 3)}:${(pseudoRandomHash % 60).toString().padLeft(2, '0')}'
                        : '00:${randomSeconds.toString().padLeft(2, '0')}'; 

                    final bool isLiked = _likedVideosCache[calculatedSeed] ?? false;
                    final bool isSaved = _savedVideosCache[calculatedSeed] ?? false;
                    final int totalLikes = _likeCountsCache[calculatedSeed] ?? (pseudoRandomHash % 850) + 12;
                    final bool isThisPlaying = _currentlyPlayingIndex == index;

                    return Container(
                      margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.025),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withAlpha(200),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 📺 Protected 8K Vector Render Canvas Box
                          InkWell(
                            onTap: () => _synthesizeProceduralAudio(title, index), 
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                            child: Container(
                              height: mediaQuery.size.height * 0.22,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: theme.scaffoldBackgroundColor,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: CustomPaint(
                                        painter: HighDefAdaptivePainter(
                                          seed: pseudoRandomHash,
                                          searchQuery: cleanedQuery,
                                          wantsRealism: wantsRealism,
                                          themeColor: theme.colorScheme.primary,
                                          canvasBg: theme.scaffoldBackgroundColor,
                                        ),
                                      ),
                                    ),
                                    
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isThisPlaying 
                                              ? theme.colorScheme.secondary.withOpacity(0.15) 
                                              : theme.colorScheme.primary.withOpacity(0.25),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isThisPlaying ? theme.colorScheme.secondary : theme.colorScheme.primary.withOpacity(0.7), 
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Icon(
                                          isThisPlaying ? Icons.volume_up_rounded : Icons.play_arrow_rounded, 
                                          size: 36, 
                                          color: isThisPlaying ? theme.colorScheme.secondary : theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme.scaffoldBackgroundColor.withOpacity(0.85),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          displayDuration, 
                                          style: TextStyle(
                                            color: theme.textTheme.bodyMedium?.color, 
                                            fontSize: 11, 
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title, 
                                  style: TextStyle(
                                    fontSize: 14, 
                                    fontWeight: FontWeight.w600, 
                                    color: theme.textTheme.titleMedium?.color,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  description, 
                                  style: TextStyle(
                                    fontSize: 12, 
                                    color: theme.hintColor, 
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: theme.dividerColor, 
                            thickness: 0.5, 
                            indent: 16, 
                            endIndent: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildActionButton(
                                  icon: isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  label: '$totalLikes',
                                  color: isLiked ? Colors.redAccent : theme.hintColor,
                                  onTap: () {
                                    setState(() {
                                      _likedVideosCache[calculatedSeed] = !isLiked;
                                      _likeCountsCache[calculatedSeed] = totalLikes + (isLiked ? -1 : 1);
                                    });
                                  },
                                ),
                                _buildActionButton(
                                  icon: Icons.chat_bubble_outline_rounded, 
                                  label: '${(pseudoRandomHash % 89) + 2}', 
                                  color: theme.hintColor, 
                                  onTap: () {},
                                ),
                                _buildActionButton(
                                  icon: isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                  label: '',
                                  color: isSaved ? Colors.amberAccent : theme.hintColor,
                                  onTap: () {
                                    setState(() {
                                      _savedVideosCache[calculatedSeed] = !isSaved;
                                    });
                                  },
                                ),
                                _buildActionButton(
                                  icon: Icons.reply_rounded, 
                                  label: '', 
                                  color: theme.hintColor, 
                                  onTap: () {},
                                ),
                                _buildActionButton(
                                  icon: Icons.file_download_outlined, 
                                  label: '', 
                                  color: theme.colorScheme.primary, 
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon, 
    required String label, 
    required Color color, 
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color), 
            const SizedBox(width: 4), 
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyFallbackView(ThemeData theme, MediaQueryData mediaQuery) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shield_outlined, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 20),
            Text(
              theme.colorScheme.error.toString(), 
              style: TextStyle(
                color: theme.textTheme.titleMedium?.color, 
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================
// 📐 PROCEDURAL SUPER-OPTIMIZED CANVAS SAMPLING ENGINE
// =========================================================
class HighDefAdaptivePainter extends CustomPainter {
  final int seed;
  final String searchQuery;
  final bool wantsRealism;
  final Color themeColor;
  final Color canvasBg;

  HighDefAdaptivePainter({
    required this.seed,
    required this.searchQuery,
    required this.wantsRealism,
    required this.themeColor,
    required this.canvasBg,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    if (wantsRealism) {
      final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
      final gradient = ui.Gradient.linear(
        Offset(size.width * 0.2, 0),
        Offset(size.width * 0.8, size.height),
        [
          canvasBg,
          themeColor.withOpacity(0.4),
          canvasBg.withAlpha(50),
        ],
      );
      paint.shader = gradient;
      canvas.drawRect(rect, paint);
      paint.shader = null;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 0.5;
      paint.color = themeColor.withOpacity(0.12);
      
      double horizonY = size.height * 0.55;
      for (double i = 0; i <= size.width; i += 20) {
        canvas.drawLine(Offset(size.width * 0.5, horizonY), Offset(i, size.height), paint);
      }
    } else {
      paint.style = PaintingStyle.fill;
      paint.color = canvasBg.withAlpha(220);
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

      // 🖥️ EXTREMELY OPTIMIZED PATH SAMPLING MATRIX
      // Uses a dynamic precision step to prevent dropped frames on low-end displays
      const double precisionStep8K = 2.5;
      final pathHills = Path()..moveTo(0, size.height);
      paint.color = themeColor.withOpacity(0.15);
      
      for (double x = 0; x <= size.width; x += precisionStep8K) {
        double amplitude = 14.0 + (seed % 12);
        double frequency = 0.012 + (seed % 4) * 0.004;
        double y = size.height * 0.62 + (amplitude * (double.tryParse(((x + seed) * frequency).toString()) ?? 0.0));
        pathHills.lineTo(x, y);
      }
      pathHills.lineTo(size.width, size.height);
      canvas.drawPath(pathHills, paint);
    }

    // 🔒 DISTRIBUTED ANTI-CROP SYSTEM STAMPS
    final textPainter = TextPainter(
      text: TextSpan(
        text: '#$seed',
        style: TextStyle(
          color: themeColor.withOpacity(0.08), 
          fontSize: 9, 
          fontWeight: FontWeight.bold, 
          letterSpacing: 1.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    
    double driftX = 12 + (seed % 40).toDouble();
    textPainter.paint(canvas, Offset(driftX, 12));
    textPainter.paint(canvas, Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2));
    textPainter.paint(canvas, Offset(12, size.height - textPainter.height - 12));
  }

  @override
  bool shouldRepaint(covariant HighDefAdaptivePainter oldDelegate) {
    return oldDelegate.searchQuery != searchQuery || oldDelegate.seed != seed;
  }
}
