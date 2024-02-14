class LevelModel {
  final int maxPlanet;
  final int stars;
  final int basketIndex;
  final String backgroundUrl;
  final String previewUrl;
  final bool isLock;

  LevelModel({
    required this.maxPlanet,
    required this.backgroundUrl,
    required this.previewUrl,
    this.basketIndex = 1,
    this.isLock = true,
    this.stars = 0,
  });

  LevelModel copyWith({int? stars, bool? isLock}) {
    return LevelModel(
      maxPlanet: maxPlanet,
      basketIndex: basketIndex,
      backgroundUrl: backgroundUrl,
      previewUrl: previewUrl,
      isLock: isLock ?? this.isLock,
      stars: stars ?? this.stars,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxPlanet': maxPlanet,
      'basketIndex': basketIndex,
      'stars': stars,
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
      maxPlanet: json['maxPlanet'],
      basketIndex: json['basketIndex'],
      backgroundUrl: json['backgroundUrl'],
      previewUrl: json['previewUrl'],
      stars: json['stars'],
      isLock: json['isLock'] ?? isLock,
    );
  }
}
