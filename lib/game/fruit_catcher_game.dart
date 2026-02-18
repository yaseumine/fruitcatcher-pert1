import 'dart:math';
import 'package:flame/events.dart'; // Wajib untuk PanDetector (gerak jari)
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/camera.dart'; // Untuk viewport kamera
import 'package:flutter/material.dart';
import 'package:gamepert1/game/components/basket.dart';
import 'package:gamepert1/game/managers/audio_manager.dart';
import 'package:gamepert1/game/components/fruit.dart';

class FruitCatcherGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Basket basket;
  late TextComponent
  scoreText; // Persiapan untuk teks skor di dalam game (opsional)

  final Random random = Random();
  double fruitSpawnTimer = 0;
  final double fruitSpawnInterval = 1.5; // Muncul setiap 1.5 detik

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  int _score = 0;
  int get score => _score;
  set score(int value) {
    _score = value;
    scoreNotifier.value = value; // Update UI Flutter saat skor berubah
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Setup Kamera agar rasio layar tetap (opsional, ikuti dosen)
    // Jika 'FixedResolutionViewport' merah/error, bisa dihapus atau diganti 'FixedSizeViewport'
    camera.viewport = FixedResolutionViewport(resolution: Vector2(400, 800));

    // Add basket (Keranjang)
    basket = Basket();
    await add(basket);

    // Play background music
    AudioManager().playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Logika Spawn Buah (Timer)
    fruitSpawnTimer += dt;
    if (fruitSpawnTimer >= fruitSpawnInterval) {
      spawnFruit();
      fruitSpawnTimer = 0;
    }
  }

  // Method untuk memunculkan buah di posisi random X
  void spawnFruit() {
    final double x = random.nextDouble() * size.x;
    // Muncul di atas layar (-50)
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
  }

  // Method untuk menggeser keranjang saat layar disentuh/digeser
  @override
  void onPanUpdate(DragUpdateInfo info) {
    // Geser posisi X keranjang sesuai gerakan jari
    basket.position.x += info.delta.global.x;

    // Batasi agar keranjang tidak keluar layar (Clamping)
    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  // Dipanggil saat buah masuk keranjang
  void incrementScore() {
    score++;
    AudioManager().playSfx('collect.mp3');
  }

  // Logika Game Over (misal kena bom)
  void gameOver() {
    AudioManager().playSfx('explosion.mp3');
    pauseEngine(); // Stop game
    // Nanti bisa tambahkan dialog Game Over disini
  }

  @override
  void onRemove() {
    AudioManager().stopBackgroundMusic();
    super.onRemove();
  }

  @override
  Color backgroundColor() => const Color(0xFF87CEEB); // Sky Blue
}
