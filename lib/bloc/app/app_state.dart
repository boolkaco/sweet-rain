part of 'app_cubit.dart';

class AppState extends Equatable {
  final List<LevelModel> levels;
  final int score;
  final int hearts;
  final bool isSpawn;
  final bool isBackgroundSound;
  final bool isButtonsSound;

  const AppState({
    required this.levels,
    this.score = 0,
    this.hearts = 3,
    this.isSpawn = false,
    this.isBackgroundSound = true,
    this.isButtonsSound = true,
  });

  @override
  List<Object?> get props => [
        levels,
        score,
        hearts,
        isSpawn,
        isBackgroundSound,
        isButtonsSound,
      ];

  AppState copyWith({
    required List<LevelModel> levels,
    int? score,
    int? hearts,
    bool? isSpawn,
    bool? isBackgroundSound,
    bool? isButtonsSound,
  }) {
    return AppState(
      levels: levels,
      score: score ?? this.score,
      hearts: hearts ?? this.hearts,
      isSpawn: isSpawn ?? this.isSpawn,
      isBackgroundSound: isBackgroundSound ?? this.isBackgroundSound,
      isButtonsSound: isButtonsSound ?? this.isButtonsSound,
    );
  }
}
