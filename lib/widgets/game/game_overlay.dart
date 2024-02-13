import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/screens/level_screen.dart';
import 'package:sweetbonanzarain/screens/menu_screen.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/theme/app_colors.dart';

class GameOverlay extends StatelessWidget {
  final LevelModel level;

  GameOverlay({super.key, required this.level});

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => const MenuScreen(
                      isLoaded: true,
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Image.asset(
                'assets/images/back_btn.png',
                width: 59,
                height: 62,
              ),
            ),
            // Expanded(
            //   child: Container(
            //     padding: const EdgeInsets.only(
            //       bottom: 2,
            //       right: 24,
            //       left: 24,
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             Image.file(
            //               ImagesService().getByFilename(assetsMap['coin_icon']!)!,
            //               width: 28,
            //               height: 30,
            //             ),
            //             const SizedBox(width: 6),
            //             Text(
            //               appState.score.toString(),
            //               style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            //                     color: AppColors.white,
            //                     height: 3.2,
            //                   ),
            //             )
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Image.file(
            //               ImagesService().getByFilename(assetsMap['ball_icon']!)!,
            //               width: 28,
            //               height: 30,
            //             ),
            //             const SizedBox(width: 6),
            //             Text(
            //               appState.balls.toString(),
            //               style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            //                     color: AppColors.white,
            //                     height: 3.2,
            //                   ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                if (context.read<AppCubit>().state.isButtonsSound) {
                  audioService.playSound('buttons_sound');
                }
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => LevelScreen(level: level),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Image.asset(
                'assets/images/settings_icon.png',
                width: 59,
                height: 62,
              ),
            ),
          ],
        );
      },
    );
  }
}
