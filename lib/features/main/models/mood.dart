class Mood {
  final String id;
  final String mood;
  final String content;
  final String title;
  final int createdAt;

  Mood({
    required this.id,
    required this.mood,
    required this.content,
    required this.title,
    required this.createdAt,
  });

  Mood.empty()
      : id = '',
        mood = '',
        content = '',
        title = '',
        createdAt = 0;

  Mood.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        mood = json['mood'],
        content = json['content'],
        title = json['title'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'mood': mood,
        'content': content,
        'title': title,
        'createdAt': createdAt,
      };
}
