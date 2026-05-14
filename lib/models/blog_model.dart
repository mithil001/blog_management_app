class BlogModel {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id']?.toString() ?? '',
      title: json['blog_name']?.toString() ??
          json['title']?.toString() ??
          json['name']?.toString() ??
          '',
      content: json['content']?.toString() ?? '',
      author: json['Author_name']?.toString() ??
          json['author']?.toString() ??
          json['userName']?.toString() ??
          'Unknown',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blog_name': title,
      'content': content,
      'Author_name': author,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    DateTime? createdAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}