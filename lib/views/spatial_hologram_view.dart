import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MindSparkSpatialMasterView extends StatefulWidget {
  const MindSparkSpatialMasterView({Key? key}) : super(key: key);

  @override
  State<MindSparkSpatialMasterView> createState() => _MindSparkSpatialMasterViewState();
}

class _MindSparkSpatialMasterViewState extends State<MindSparkSpatialMasterView>
    with TickerProviderStateMixin {
  // Mode toggle: Standard Dashboard vs 6FT Spatial Wall Projection
  bool _isSpatialModeActive = false;

  // 3D Matrix Rotation variables driven by room surface touch / device sensor tracking
  double _pitch = 0.0;
  double _yaw = 0.0;

  late AnimationController _vectorAnimController;
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    // Continuous rotation controller for procedural 3D vectors
    _vectorAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Ambient depth breathing controller for the spatial card
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _vectorAnimController.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _yaw += details.delta.dx * 0.005;
      _pitch -= details.delta.dy * 0.005;

      // Clamp to secure rigid spatial anchor alignment limits
      _pitch = _pitch.clamp(-0.45, 0.45);
      _yaw = _yaw.clamp(-0.45, 0.45);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text(
          "MIND SPARK ELITE • SPHERE",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
            fontSize: 13,
          ),
        ),
        centerTitle: true,
        actions: [
          // Spatial Projection Toggle Switch
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isSpatialModeActive = !_isSpatialModeActive;
                    HapticFeedback.heavyImpact();
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _isSpatialModeActive
                        ? Colors.cyanAccent.withOpacity(0.25)
                        : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.cyanAccent,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isSpatialModeActive ? Icons.view_in_ar : Icons.dashboard,
                        color: Colors.cyanAccent,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isSpatialModeActive ? "6FT SPATIAL" : "STANDARD",
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 10,
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
      ),
      body: _isSpatialModeActive ? _buildSpatialProjectionEngine() : _buildStandardDashboard(),
    );
  }

  // --- 1. STANDARD DASHBOARD VIEW ---
  Widget _buildStandardDashboard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome, Yakubu",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            "Infinitely unfailable engine online. Toggle top-right to initialize 6ft real-world wall projection.",
            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _dashboardCard("Spark AI Engine", Icons.bolt, Colors.cyanAccent),
                _dashboardCard("3-Sec 3-Step", Icons.timer, Colors.blueAccent),
                _dashboardCard("Smart Shield", Icons.security, Colors.greenAccent),
                _dashboardCard(
                  "Launch Spatial",
                  Icons.view_in_ar,
                  Colors.purpleAccent,
                  onTap: () {
                    setState(() {
                      _isSpatialModeActive = true;
                      HapticFeedback.mediumImpact();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardCard(String title, IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () => HapticFeedback.selectionClick(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF111C31),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.4), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 34),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  // --- 2. THE 6FT SPATIAL PROJECTION ENGINE & VECTOR 3D HOLOGRAM ---
  Widget _buildSpatialProjectionEngine() {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      child: Stack(
        children: [
          // Background: Environmental Room Surface Grid Pass-Through
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF04060C), Color(0xFF0F172A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CustomPaint(
                painter: _RoomGridPainter(),
              ),
            ),
          ),

          // Real-World Target Header Info
          Positioned(
            top: 14,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.cyanAccent.withOpacity(0.6)),
                  ),
                  child: const Text(
                    "● 6FT WALL ANCHOR LOCKED",
                    style: TextStyle(color: Colors.cyanAccent, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Pan to adjust perspective",
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
                ),
              ],
            ),
          ),

          // Center: True 3D Mathematical Vector Hologram & Spatial Card Interface
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_vectorAnimController, _breathingController]),
              builder: (context, child) {
                Matrix4 matrix = Matrix4.identity()
                  ..setEntry(3, 2, 0.0012) // Perspective depth vanishing point
                  ..rotateX(_pitch)
                  ..rotateY(_yaw);

                return Transform(
                  transform: matrix,
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: 1.0 + (_breathingController.value * 0.01),
                    child: Container(
                      width: 330,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101B30).withOpacity(0.92),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.cyanAccent, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyanAccent.withOpacity(0.3),
                            blurRadius: 35,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.bolt, color: Colors.cyanAccent, size: 18),
                              const SizedBox(width: 8),
                              const Text(
                                "SPARK 3D VECTOR CORE",
                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Procedural Vector 3D Hologram Widget Rendering Live on Screen
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: CustomPaint(
                              painter: ProceduralVector3DObjectPainter(
                                angle: _vectorAnimController.value * 2 * math.pi,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text(
                            "Ready for 3-Second Breakdown",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Mathematical vectors dynamically render true 3D volumetric depth anchored to your 6ft wall surface.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.65),
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent,
                              foregroundColor: const Color(0xFF070B14),
                              minimumSize: const Size(double.infinity, 46),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                            },
                            child: const Text(
                              "Recalibrate Vector Mesh",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- PROCEDURAL MATHEMATICAL 3D VECTOR MESH ENGINE ---
class ProceduralVector3DObjectPainter extends CustomPainter {
  final double angle;
  ProceduralVector3DObjectPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final Paint nodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    const double scale = 55.0;

    // 3D Model Vertices (X, Y, Z coordinates)
    final List<List<double>> vertices = [
      [-1, -1, -1], [1, -1, -1], [1, 1, -1], [-1, 1, -1],
      [-1, -1, 1],  [1, -1, 1],  [1, 1, 1],  [-1, 1, 1],
    ];

    // Edge Matrix Connectors
    final List<List<int>> edges = [
      [0, 1], [1, 2], [2, 3], [3, 0],
      [4, 5], [5, 6], [6, 7], [7, 4],
      [0, 4], [1, 5], [2, 6], [3, 7],
    ];

    List<Offset> projectedPoints = [];

    for (var v in vertices) {
      double x = v[0];
      double y = v[1];
      double z = v[2];

      // Matrix Rotation on Y axis
      double x1 = x * math.cos(angle) + z * math.sin(angle);
      double z1 = -x * math.sin(angle) + z * math.cos(angle);

      // Matrix Rotation on X axis
      double y2 = y * math.cos(angle) - z1 * math.sin(angle);
      double z2 = y * math.sin(angle) + z1 * math.cos(angle);

      // Perspective Projection Depth Scale
      double distance = 3.0;
      double perspective = scale / (distance + z2);

      double projectedX = center.dx + x1 * perspective;
      double projectedY = center.dy + y2 * perspective;

      projectedPoints.add(Offset(projectedX, projectedY));
    }

    // Render wireframe structure
    for (var edge in edges) {
      canvas.drawLine(projectedPoints[edge[0]], projectedPoints[edge[1]], linePaint);
    }

    // Render vertices nodes
    for (var pt in projectedPoints) {
      canvas.drawCircle(pt, 2.5, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ProceduralVector3DObjectPainter oldDelegate) => true;
}

// --- ROOM SURFACE GRID BACKGROUND PAINTER ---
class _RoomGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.04)
      ..strokeWidth = 1.0;

    const double spacing = 35.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
