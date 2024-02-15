import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sweetbonanzarain/const/levels.dart';
import 'package:sweetbonanzarain/models/level_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(levels: Levels.list));

  void saveLevels() async {
    var box = await Hive.openBox('box');
    List<Map<String, dynamic>> levelsJson =
        state.levels.map((level) => level.toJson()).toList();

    await box.put('levels', levelsJson);
    await box.close();
  }

  Future<void> loadLevels() async {
    var box = await Hive.openBox('box');
    var levelsJson = await box.get('levels');

    if (levelsJson != null) {
      List<LevelModel> loadedLevels = [];
      for (int i = 0; i < levelsJson.length; i++) {
        Map<String, dynamic> castedLevelMap =
            Map<String, dynamic>.from(levelsJson[i]);
        bool isLock = i == 0 ? false : castedLevelMap['isLock'] ?? true;
        loadedLevels.add(LevelModel.fromJson(castedLevelMap, isLock: isLock));
      }

      emit(state.copyWith(levels: loadedLevels));
    }
    await box.close();
  }

  void finishLevel(LevelModel level, bool isWon) {
    List<LevelModel> updatedLevels = List.from(state.levels);

    int currentIndex = updatedLevels.indexWhere((l) => l == level);

    if (currentIndex != -1) {
      if (currentIndex < updatedLevels.length - 1) {
        updatedLevels[currentIndex + 1] =
            updatedLevels[currentIndex + 1].copyWith(isLock: !isWon);
      }
    }

    saveLevels();
    emit(state.copyWith(levels: updatedLevels, isSpawn: false));
  }

  void addScore(int points) {
    final newScore = state.score + points;
    emit(state.copyWith(
      levels: state.levels,
      score: newScore < 0 ? 0 : newScore,
      hearts: state.hearts,
    ));
  }

  void onSweetMissed() {
    if (state.hearts > 0) {
      emit(state.copyWith(
        levels: state.levels,
        score: state.score,
        hearts: state.hearts - 1,
      ));
    }
  }

  void resetGame() {
    emit(state.copyWith(
      levels: state.levels,
      hearts: 3,
      score: 0,
      isSpawn: true,
      isButtonsSound: state.isButtonsSound,
      isBackgroundSound: state.isBackgroundSound,
    ));
  }

  void setSpawn(bool status) {
    emit(state.copyWith(
      levels: state.levels,
      isSpawn: status,
    ));
  }

  void updateBackgroundSound() {
    emit(state.copyWith(
      levels: state.levels,
      isBackgroundSound: !state.isBackgroundSound,
    ));
  }

  void updateButtonsSound() {
    emit(state.copyWith(
      levels: state.levels,
      isButtonsSound: !state.isButtonsSound,
    ));
  }
}
