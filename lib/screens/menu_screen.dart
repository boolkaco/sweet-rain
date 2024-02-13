import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/screens/level_screen.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/utils/layout_wrapper.dart';
import 'package:sweetbonanzarain/utils/lifecircle_event_handler.dart';
import 'package:sweetbonanzarain/widgets/menu/level_select_menu.dart';

class MenuScreen extends StatefulWidget {
  final bool isLoaded;

  const MenuScreen({super.key, this.isLoaded = false});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  final AudioService audioService = AudioService();
  late LifecycleEventHandler _lifecycleEventHandler;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _isLoaded = widget.isLoaded;
    _lifecycleEventHandler = LifecycleEventHandler(
      audioService: context.read<AudioService>(),
    );
    WidgetsBinding.instance.addObserver(_lifecycleEventHandler);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleEventHandler);
    super.dispose();
  }

  void _selectLevel(LevelModel level) {
    if (!level.isLock) {
      if (context.read<AppCubit>().state.isButtonsSound) {
        audioService.playSound('buttons_sound');
      }
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LevelScreen(
            level: level,
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BackgroundWrapper(
          isAnimate: _isLoaded,
          isStatic: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                const SizedBox(
                  height: 320,
                ),
                if (_isLoaded)
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: appState.levels.length,
                      itemBuilder: (context, index) {
                        return LevelSelectMenu(
                          backgroundUrl: appState.levels[index].previewUrl,
                          isRightPlay: index % 2 == 0,
                          isLock: appState.levels[index].isLock,
                          score: appState.levels[index].stars,
                          onTap: () => _selectLevel(appState.levels[index]),
                        );
                      },
                    ),
                  )
                else
                  Container()
              ],
            ),
          ),
        );
      },
    );
  }
}
