import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FruitCatcherGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF87CEEB); // Warna biru langit

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Di sini nanti kita akan memuat aset gambar buah & keranjang
  }
}
