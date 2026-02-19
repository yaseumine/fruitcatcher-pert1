import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:gamepert1/game/managers/audio_manager.dart'; // Pastikan path import ini benar
import 'game/fruit_catcher_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioManager().initialize(); // Init Audio
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Tangkap Buah',
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // HAPUS: final ValueNotifier<int> counter... (Kita pakai skor dari Game)
  late FruitCatcherGame game;

  @override
  void initState() {
    super.initState();
    game = FruitCatcherGame();
  }

  @override
  void dispose() {
    game.onRemove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),

          Positioned(
            top: 50,
            left: 20, // Geser dikit biar rapi
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    Colors.black54, // Ganti transparan hitam biar lebih gaming
                borderRadius: BorderRadius.circular(10),
              ),

              child: ValueListenableBuilder<int>(
                valueListenable: game.scoreNotifier,
                builder: (context, score, child) {
                  return Text(
                    'Score: $score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                  ), // Putih biar kontras
                  onPressed: () {
                    AudioManager().toggleMusic();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.white),
                  onPressed: () {
                    AudioManager().toggleSfx();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Tombol "Tambah Score" DIHAPUS karena skor nambah otomatis kalau nangkep buah
    );
  }
}
