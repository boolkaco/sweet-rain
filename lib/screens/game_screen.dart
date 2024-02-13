import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/screens/end_screen.dart';
import 'package:sweetbonanzarain/utils/layout_wrapper.dart';
import 'package:sweetbonanzarain/widgets/game/game_overlay.dart';
import 'package:sweetbonanzarain/widgets/game/bonanza_game.dart';

class GameScreen extends StatelessWidget {
  final LevelModel level;

  GameScreen({super.key, required this.level});

  final GlobalKey<GameWidgetState> gameKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      opacity: 1,
      isShownLogo: false,
      backgroundUrl: level.backgroundUrl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GameWidget<BonanzaGame>(
              key: gameKey,
              game: BonanzaGame(
                level: level,
                appCubit: context.read<AppCubit>(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 35, left: 35),
              child: Column(
                children: [
                  BlocListener<AppCubit, AppState>(
                    listener: (context, state) {
                      if (state.score >= 700 || state.balls == 0) {
                        final isWon = state.score >= 700;
                        final bonanzoGameState =
                            gameKey.currentState as GameWidgetState<BonanzaGame>;
                        final bonanzoGame = bonanzoGameState.widget.game;
                        bonanzoGame?.finishLevel(isWon);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndScreen(
                              level: level,
                              isWon: isWon,
                            ),
                          ),
                        );
                      }
                    },
                    child: GameOverlay(level: level),
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
