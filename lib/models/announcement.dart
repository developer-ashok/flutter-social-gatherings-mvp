import 'dart:convert';

class Announcement {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final bool isImportant;
  final List<String> tags;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.isImportant,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': createdAt.toIso8601String(),
      'isImportant': isImportant ? 1 : 0,
      'tags': jsonEncode(tags),
    };
  }

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      authorId: json['authorId'],
      authorName: json['authorName'],
      createdAt: DateTime.parse(json['createdAt']),
      isImportant: json['isImportant'] == 1 || json['isImportant'] == true,
      tags: List<String>.from(jsonDecode(json['tags'])),
    );
  }
} 