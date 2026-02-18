import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:gamepert1/game/managers/audio_manager.dart';
import 'game/components/fruit_catcher_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioManager().initialize(); // [cite: 540]
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'game tangkap buah ', home: const GameScreen());
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ValueNotifier<int> counter = ValueNotifier(0);
  late FruitCatcherGame game;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    game.onRemove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GameWidget(game: game),
                Container(color: Colors.white),
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ValueListenableBuilder<int>(
                      valueListenable: counter,
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
                  right: 50,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.music_note, color: Colors.black),
                        onPressed: () {
                          AudioManager().toggleMusic();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.black),
                        onPressed: () {
                          AudioManager().toggleSfx();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                counter.value++;
              },
              child: const Text("Tambah Score"),
            ),
          ),
        ],
      ),
    );
  }
}
