import 'package:sweetbonanzarain/theme/app_colors.dart';
import 'package:sweetbonanzarain/widgets/common/shadow_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/utils/layout_wrapper.dart';
import 'package:sweetbonanzarain/widgets/back_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BackgroundWrapper(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                const SizedBox(
                  height: 320,
                ),
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/settings_bg.png',
                      fit: BoxFit.fill,
                      height: 300
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 34,
                          ),
                          ShadowText(
                            'settings'.tr(),
                            shadowColor: AppColors.toryBlue,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AppCubit>().updateBackgroundSound();
                                  if (!appState.isBackgroundSound) {
                                    context.read<AudioService>().unMuteBackgroundMusic();
                                  } else {
                                    context.read<AudioService>().muteBackgroundMusic();
                                  }
                                },
                                child: Image.asset(
                                  appState.isBackgroundSound
                                      ? 'assets/images/checkbox_enable.png'
                                      : 'assets/images/checkbox_disable.png',
                                  fit: BoxFit.fill,
                                  width: 49,
                                  height: 55,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                width: 80,
                                child: ShadowText(
                                  'main_sound'.tr(),
                                  shadowColor: AppColors.toryBlue,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AppCubit>()
                                      .updateButtonsSound();
                                },
                                child: Image.asset(
                                  appState.isButtonsSound
                                      ? 'assets/images/checkbox_enable.png'
                                      : 'assets/images/checkbox_disable.png',
                                  fit: BoxFit.fill,
                                  width: 49,
                                  height: 55,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                width: 80,
                                child: ShadowText(
                                  'button_sound'.tr(),
                                  shadowColor: AppColors.toryBlue,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container(),),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AppBackButton(),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
