import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AudioService audioService;

  LifecycleEventHandler({required this.audioService});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        audioService.stopBackgroundMusic();
        break;
      case AppLifecycleState.resumed:
        audioService.loopSound('background_sound');
        break;
      default:
    }
  }
}
