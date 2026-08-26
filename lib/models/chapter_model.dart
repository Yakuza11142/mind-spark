class ChapterModel {
  final int chapterId;
  final String title;
  final List<String> levelDetails;
  final bool isUnlocked;

  ChapterModel({
    required this.chapterId,
    required this.title,
    required this.levelDetails,
    required this.isUnlocked,
  });

  Map<String, dynamic> toJson() => {
        'chapterId': chapterId,
        'title': title,
        'levelDetails': levelDetails,
        'isUnlocked': isUnlocked,
      };

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      chapterId: json['chapterId'] ?? 1,
      title: json['title'] ?? '',
      levelDetails: List<String>.from(json['levelDetails'] ?? []),
      isUnlocked: json['isUnlocked'] ?? false,
    );
  }
}
