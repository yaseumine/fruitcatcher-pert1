import 'package:flutter/material.dart';

void main() {
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
  final ValueNotifier<int> counter = ValueNotifier(1);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: counter,
                      builder: (context, score, child) {
                        return Text(
                          'Score: $score',
                          style: TextStyle(
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
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.black),
                        onPressed: () {},
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
}
