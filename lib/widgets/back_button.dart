import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/screens/menu_screen.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';

class AppBackButton extends StatelessWidget {
  final Function()? callback;

  AppBackButton({super.key, this.callback});

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
        } else {
          Navigator.pop(context);
        }
      },
      child: Image.asset(
        'assets/images/back_btn.png',
        fit: BoxFit.fill,
        width: 50,
        height: 55,
      ),
    );
  }
}
