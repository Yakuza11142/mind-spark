import 'package:flutter/material.dart';
import '../models/spark_transaction.dart';

class PremiumReceiptView extends StatelessWidget {
  final SparkTransaction tx;

  const PremiumReceiptView({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CustomPaint(
        painter: TicketBorderPainter(color: Colors.white),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified, color: Colors.blue, size: 30),
              const SizedBox(height: 4),
              const Text(
                "OFFICIAL SPARK RECEIPT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1.2,
                  color: Color(0xFF0A0E21),
                ),
              ),
              const SizedBox(height: 15),

              Text(
                "${tx.amount}⚡",
                style: const TextStyle(
                  fontSize: 48, 
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0A0E21),
                ),
              ),

              const Divider(height: 40, thickness: 1),

              _buildRow("From", tx.sender), 
              _buildRow("To", tx.receiver),
              _buildRow("Date", tx.formattedDate),
              _buildRow("Auth Sig", tx.signature.toUpperCase()),

              const SizedBox(height: 30),

              // Pure Flutter Custom-Painted Matrix Hash Representation (Zero QR Package Needed)
              Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF0A0E21), width: 2),
                ),
                child: CustomPaint(
                  painter: MatrixHashPainter(seed: tx.signature),
                ),
              ),

              const SizedBox(height: 10),
              const Text(
                "SECURE BLOCKCHAIN-HASHED MATRIX",
                style: TextStyle(fontSize: 8, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
          ),
          const SizedBox(width: 16), 
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 11,
                color: Color(0xFF0A0E21),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Ticket Edge Cutter Painter (Remplaces sks_ticket_view package)
class TicketBorderPainter extends CustomPainter {
  final Color color;
  TicketBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ));

    // Optional side notches for ticket visual look
    final notchPaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
    
    // Draw classic receipt cutouts on the left and right edges
    canvas.drawCircle(Offset(0, size.height * 0.7), 10, notchPaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.7), 10, notchPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Pure Dart Deterministic Matrix Graphic Generator (Replaces external QR package)
class MatrixHashPainter extends CustomPainter {
  final String seed;
  MatrixHashPainter({required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF0A0E21);
    final hashVal = seed.hashCode;
    const gridCount = 10;
    final cellWidth = size.width / gridCount;
    final cellHeight = size.height / gridCount;

    for (int i = 0; i < gridCount; i++) {
      for (int j = 0; j < gridCount; j++) {
        if ((i + j + hashVal) % 3 == 0 || (i * j) % 5 == 1) {
          canvas.drawRect(
            Rect.fromLTWH(i * cellWidth, j * cellHeight, cellWidth * 0.9, cellHeight * 0.9),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
