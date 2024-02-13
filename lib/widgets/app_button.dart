import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/common/shadow_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';

enum AppButtonType { start, settings, privacy, exit }

class AppButton extends StatelessWidget {
  final AppButtonType type;
  final String label;
  final Function() onTap;
  final AudioService audioService = AudioService();

  AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.type = AppButtonType.start,
  });

  double _getCustomWidth(double screenWidth) {
    if (type == AppButtonType.start) {
      return screenWidth * 0.5;
    } else if (type == AppButtonType.settings) {
      return screenWidth * 0.6;
    } else if (type == AppButtonType.privacy) {
      return screenWidth * 0.7;
    } else {
      return screenWidth * 0.4;
    }
  }

  double _getCustomHeight(double screenWidth, {double shadowHeight = 0}) {
    return (screenWidth * 0.1) - shadowHeight;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        if (context.read<AppCubit>().state.isButtonsSound) {
          audioService.playSound('buttons_sound');
        }
        onTap();
      },
      child: Stack(
        children: [
          Image.file(
            ImagesService().getByFilename(assetsMap['${type.name}_btn']!)!,
            width: _getCustomWidth(screenWidth),
            height: _getCustomHeight(screenHeight),
          ),
          SizedBox(
            width: _getCustomWidth(screenWidth),
            height: _getCustomHeight(screenHeight, shadowHeight: 6),
            child: Center(
              child: ShadowText(
                label,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
