import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/screens/menu_screen.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/services/images_service.dart';

class AppBackButton extends StatelessWidget {
  final Function()? callback;
  final bool toMenu;

  AppBackButton({super.key, this.callback, this.toMenu = false});

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.read<AppCubit>().state.isButtonsSound) {
          audioService.playSound('buttons_sound');
        }
        if (callback != null) {
          callback!();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MenuScreen(
                isLoaded: true,
              ),
            ),
          );
        } else if (toMenu) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MenuScreen(
                isLoaded: true,
              ),
            ),
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: Image.file(
        ImagesService().getByFilename(assetsMap['back_btn']!)!,
        fit: BoxFit.fill,
        width: 50,
        height: 55,
      ),
    );
  }
}
