part of 'app_cubit.dart';

class AppState extends Equatable {
  final List<LevelModel> levels;
  final int score;
  final int balls;
  final bool isBackgroundSound;
  final bool isButtonsSound;

  const AppState({
    required this.levels,
    this.score = 0,
    this.balls = 10,
    this.isBackgroundSound = true,
    this.isButtonsSound = true,
  });

  @override
  List<Object?> get props => [
        levels,
        score,
        balls,
        isBackgroundSound,
        isButtonsSound,
      ];

  AppState copyWith({
    required List<LevelModel> levels,
    int? score,
    int? balls,
    bool? isBackgroundSound,
    bool? isButtonsSound,
  }) {
    return AppState(
      levels: levels, // can't be null
      score: score ?? this.score,
      balls: balls ?? this.balls,
      isBackgroundSound: isBackgroundSound ?? this.isBackgroundSound,
      isButtonsSound: isButtonsSound ?? this.isButtonsSound,
    );
  }
}
