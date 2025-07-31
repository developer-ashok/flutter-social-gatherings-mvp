import 'dart:convert';

class Poll {
  final String id;
  final String question;
  final List<PollOption> options;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final bool isActive;
  final List<String> votedBy;

  Poll({
    required this.id,
    required this.question,
    required this.options,
    required this.createdBy,
    required this.createdAt,
    this.expiresAt,
    required this.isActive,
    required this.votedBy,
  });

  int get totalVotes {
    return options.fold(0, (sum, option) => sum + option.votes);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options.map((option) => option.toJson()).toList(),
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'votedBy': jsonEncode(votedBy),
    };
  }

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      question: json['question'],
      options: (json['options'] as List)
          .map((option) => PollOption.fromJson(option))
          .toList(),
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
      isActive: json['isActive'] == 1 || json['isActive'] == true,
      votedBy: List<String>.from(jsonDecode(json['votedBy'])),
    );
  }
}

class PollOption {
  final String id;
  final String text;
  final int votes;

  PollOption({
    required this.id,
    required this.text,
    required this.votes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'votes': votes,
    };
  }

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      id: json['id'],
      text: json['text'],
      votes: json['votes'],
    );
  }

  PollOption copyWith({
    String? id,
    String? text,
    int? votes,
  }) {
    return PollOption(
      id: id ?? this.id,
      text: text ?? this.text,
      votes: votes ?? this.votes,
    );
  }
} 