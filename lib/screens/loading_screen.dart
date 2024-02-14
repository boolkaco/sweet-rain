// ignore_for_file: use_build_context_synchronously

import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/screens/menu_screen.dart';
import 'package:sweetbonanzarain/utils/image_loader.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      for (var asset in assetsMap.values) {
        await ImageLoader().loadImage(asset);
      }

      await context.read<AudioService>().loadSounds(soundsMap);
      await context.read<AppCubit>().loadLevels();

      // context.read<AudioService>().stopBackgroundMusic();
      // context.read<AudioService>().loopSound('background_sound');

      Future.delayed(const Duration(seconds: 0), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const MenuScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cerise,
      body: Center(
        child: Text(
          'loading'.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
