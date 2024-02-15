import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/screens/end_screen.dart';
import 'package:sweetbonanzarain/utils/layout_wrapper.dart';
import 'package:sweetbonanzarain/widgets/game/game_overlay.dart';
import 'package:sweetbonanzarain/widgets/game/bonanza_game.dart';

class GameScreen extends StatefulWidget {
  final LevelModel level;

  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GlobalKey<GameWidgetState> gameKey = GlobalKey();
  bool listenerActive = true;

  @override
  void dispose() {
    listenerActive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundWrapper(
      opacity: 1,
      isShownLogo: false,
      backgroundUrl: widget.level.backgroundUrl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GameWidget<BonanzaGame>(
              key: gameKey,
              game: BonanzaGame(
                level: widget.level,
                appCubit: context.read<AppCubit>(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 60,
                right: size.width * 0.06,
                left: size.width * 0.06,
              ),
              child: Column(
                children: [
                  BlocListener<AppCubit, AppState>(
                    listener: (context, state) {
                      if (listenerActive && mounted) {
                        if (state.isSpawn) {
                          if (state.score >= widget.level.targetScores ||
                              state.hearts == 0) {
                            final isWon =
                                state.score >= widget.level.targetScores &&
                                    state.hearts > 0;
                            final bonanzaGameState = gameKey.currentState
                            as GameWidgetState<BonanzaGame>;
                            final bonanzaGame = bonanzaGameState.widget.game;
                            bonanzaGame?.finishLevel(isWon);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => EndScreen(
                                  level: widget.level,
                                  isWon: isWon,
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: GameOverlay(
                      level: widget.level,
                      gameKey: gameKey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
