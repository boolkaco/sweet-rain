import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String basePath = dotenv.env['DOMAIN_URL']!;
  bool isBackgroundMusicPlaying = false;

  Future<void> loadSounds(Map<String, String> soundsMap) async {
    final directory = await getApplicationDocumentsDirectory();

    for (String key in soundsMap.keys) {
      // TODO: replace base url to bonanza.com
      final url = 'https://plincogame.com' + soundsMap[key]!;
      final filePath = '${directory.path}/$key.mp3';
      final fileExists = await File(filePath).exists();

      if (!fileExists) {
        final response = await http.get(Uri.parse(url));
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
      }
    }
  }

  Future<void> playSound(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.mp3';
    await _audioPlayer.play(DeviceFileSource(filePath));
  }

  Future<void> loopSound(String fileName) async {
    if (!isBackgroundMusicPlaying) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName.mp3';
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(DeviceFileSource(filePath));
      isBackgroundMusicPlaying = true;
    }
  }

  Future<void> stopBackgroundMusic() async {
    await _audioPlayer.stop();
    isBackgroundMusicPlaying = false;
  }

  Future<void> muteBackgroundMusic() async {
    await _audioPlayer.setVolume(0);
  }

  Future<void> unMuteBackgroundMusic() async {
    await _audioPlayer.setVolume(1);
  }
}
