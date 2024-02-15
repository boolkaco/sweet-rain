import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/screens/level_screen.dart';
import 'package:sweetbonanzarain/screens/menu_screen.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/common/stroke_text.dart';
import 'package:sweetbonanzarain/widgets/game/bonanza_game.dart';
import 'package:sweetbonanzarain/widgets/hearts_bar.dart';
import 'package:sweetbonanzarain/widgets/score_bar.dart';

class GameOverlay extends StatelessWidget {
  final LevelModel level;
  final GlobalKey<GameWidgetState> gameKey;

  GameOverlay({
    super.key,
    required this.level,
    required this.gameKey,
  });

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (context.read<AppCubit>().state.isButtonsSound) {
                  audioService.playSound('buttons_sound');
                }
                BlocProvider.of<AppCubit>(context).setSpawn(false);
                final bonanzaGameState =
                    gameKey.currentState as GameWidgetState<BonanzaGame>;
                final bonanzaGame = bonanzaGameState.widget.game;
                bonanzaGame?.stopSpawning();
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const MenuScreen(
                      isLoaded: true,
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Image.file(
                ImagesService().getByFilename(assetsMap['back_btn']!)!,
                width: size.width * 0.12,
                // height: 62,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 2,
                  right: 24,
                  left: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeartsBar(
                      filledHearts: appState.hearts,
                    ),
                    ScoreBar(
                      score: appState.score,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (context.read<AppCubit>().state.isButtonsSound) {
                  audioService.playSound('buttons_sound');
                }
                BlocProvider.of<AppCubit>(context).setSpawn(false);
                final bonanzaGameState =
                    gameKey.currentState as GameWidgetState<BonanzaGame>;
                final bonanzaGame = bonanzaGameState.widget.game;
                bonanzaGame?.stopSpawning();
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        LevelScreen(
                      level: level,
                      toMenu: true,
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Image.file(
                ImagesService().getByFilename(assetsMap['settings_icon']!)!,
                width: size.width * 0.12,
              ),
            ),
          ],
        );
      },
    );
  }
}
