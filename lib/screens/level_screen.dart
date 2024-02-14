import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/screens/game_screen.dart';
import 'package:sweetbonanzarain/screens/privacy_screen.dart';
import 'package:sweetbonanzarain/screens/settings_screen.dart';
import 'package:sweetbonanzarain/utils/layout_wrapper.dart';
import 'package:sweetbonanzarain/widgets/app_button.dart';
import 'package:sweetbonanzarain/widgets/back_button.dart';

class LevelScreen extends StatelessWidget {
  final LevelModel level;
  final bool toMenu;

  const LevelScreen({
    super.key,
    required this.level,
    this.toMenu = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(
              height: 320,
            ),
            Expanded(
              child: Column(
                children: [
                  AppButton(
                    label: "start".tr(),
                    type: AppButtonType.start,
                    onTap: () {
                      BlocProvider.of<AppCubit>(context).resetGame();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              GameScreen(level: level),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.01,
                  // ),
                  AppButton(
                    label: "settings".tr(),
                    type: AppButtonType.settings,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                          const SettingsScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.01,
                  // ),
                  AppButton(
                    label: "privacy".tr(),
                    type: AppButtonType.privacy,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              PrivacyScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.01,
                  // ),
                  AppButton(
                    label: "exit".tr(),
                    type: AppButtonType.exit,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              PrivacyScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppBackButton(
                toMenu: toMenu,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
