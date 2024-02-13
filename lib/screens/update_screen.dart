import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/theme/app_colors.dart';
import 'package:sweetbonanzarain/widgets/common/shadow_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/utils/layout_wrapper.dart';
import 'package:sweetbonanzarain/widgets/back_button.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({
    super.key,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                Image.file(
                  ImagesService().getByFilename(assetsMap['update_bg']!)!,
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
                        tr('update'),
                        shadowColor: AppColors.cerise.withOpacity(0.5),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ShadowText(
                        'update_desc'.tr(),
                        textAlign: TextAlign.center,
                        shadowColor: AppColors.cerise.withOpacity(0.5),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (context.read<AppCubit>().state.isButtonsSound) {
                  audioService.playSound('buttons_sound');
                }
              },
              child: Stack(
                children: [
                  Image.file(
                    ImagesService().getByFilename(assetsMap['restart_bg']!)!,
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
                          tr('reboot'),
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
