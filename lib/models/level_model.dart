class LevelModel {
  final int maxSweets;
  final int targetScores;
  final int basketIndex;
  final double speed;
  final String backgroundUrl;
  final String previewUrl;
  final bool isLock;

  LevelModel({
    required this.maxSweets,
    required this.backgroundUrl,
    required this.previewUrl,
    required this.speed,
    this.basketIndex = 1,
    this.isLock = true,
    this.targetScores = 1000,
  });

  LevelModel copyWith({int? targetScores, bool? isLock}) {
    return LevelModel(
      maxSweets: maxSweets,
      basketIndex: basketIndex,
      backgroundUrl: backgroundUrl,
      previewUrl: previewUrl,
      isLock: isLock ?? this.isLock,
      targetScores: targetScores ?? this.targetScores,
      speed: speed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxSweets': maxSweets,
      'basketIndex': basketIndex,
      'targetScores': targetScores,
      'speed': speed,
      'isLock': isLock,
      'backgroundUrl': backgroundUrl,
      'previewUrl': previewUrl,
    };
  }

  factory LevelModel.fromJson(
    Map<String, dynamic> json, {
    bool isLock = true,
  }) {
    return LevelModel(
      maxSweets: json['maxSweets'],
      basketIndex: json['basketIndex'],
      backgroundUrl: json['backgroundUrl'],
      previewUrl: json['previewUrl'],
      targetScores: json['targetScores'],
      speed: json['speed'],
      isLock: json['isLock'] ?? isLock,
    );
  }
}
