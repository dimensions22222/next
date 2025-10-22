import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final Widget child;
  const TicketCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TicketCardPainter(),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: child,
      ),
    );
  }
}

class TicketCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE9E9FF)
      ..style = PaintingStyle.fill;

    const notchRadius = 16.0;
    final rRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(14));

    final path = Path()..addRRect(rRect);

    // Left notch
    path.addOval(Rect.fromCircle(
        center: Offset(0, size.height / 2), radius: notchRadius));
    // Right notch
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: notchRadius));

    // Use even-odd fill to cut holes
    path.fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
