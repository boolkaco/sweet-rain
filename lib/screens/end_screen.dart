import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/theme/app_colors.dart';
import 'package:sweetbonanzarain/widgets/common/shadow_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/screens/game_screen.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/utils/layout_wrapper.dart';
import 'package:sweetbonanzarain/widgets/back_button.dart';

class EndScreen extends StatefulWidget {
  final bool isWon;
  final LevelModel level;

  const EndScreen({
    super.key,
    required this.level,
    this.isWon = false,
  });

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  final AudioService audioService = AudioService();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context).setSpawn(false);

    audioService.playSound(widget.isWon ? 'success_sound' : 'fail_sound');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.file(
                  widget.isWon
                      ? ImagesService().getByFilename(assetsMap['win_bg']!)!
                      : ImagesService().getByFilename(assetsMap['lose_bg']!)!,
                  fit: BoxFit.fill,
                  width: size.width * 0.7,
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 34,
                      ),
                      ShadowText(
                        widget.isWon ? 'congrats'.tr() : 'lose'.tr(),
                        shadowColor: AppColors.blackberry,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ShadowText(
                        widget.isWon ? 'won'.tr() : 'game_over'.tr(),
                        size: 44,
                        shadowColor: AppColors.blackberry,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -size.height * 0.04,
                  child: Image.file(
                    widget.isWon
                        ? ImagesService().getByFilename(assetsMap['candy']!)!
                        : ImagesService().getByFilename(assetsMap['bomb']!)!,
                    height: size.height * 0.14,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            GestureDetector(
              onTap: () {
                if (context.read<AppCubit>().state.isButtonsSound) {
                  audioService.playSound('buttons_sound');
                }
                BlocProvider.of<AppCubit>(context).resetGame();
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => GameScreen(
                      level: widget.level,
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: Stack(
                children: [
                  Image.file(
                    ImagesService().getByFilename(assetsMap['restart_btn']!)!,
                    fit: BoxFit.fill,
                    height: size.height * 0.08,
                  ),
                  Positioned.fill(
                    bottom: 4,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShadowText(
                          widget.isWon ? 'try_again'.tr() : 'play_again'.tr(),
                          shadowColor: AppColors.toryBlue,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppBackButton(
                callback: () {
                  BlocProvider.of<AppCubit>(context).resetGame();
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
