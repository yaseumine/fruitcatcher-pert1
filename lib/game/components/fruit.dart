import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent with HasGameRef, CollisionCallbacks {
  Basket() : super(size: Vector2(80, 60)); // [cite: 582]

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Posisi di tengah bawah
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    anchor = Anchor.center;
    add(RectangleHitbox()); // [cite: 589]
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Gambar keranjang [cite: 601-605]
    final paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(10),
    );
    canvas.drawRRect(rect, paint);
  }
}
