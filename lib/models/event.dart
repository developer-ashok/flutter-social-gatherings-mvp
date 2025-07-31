import 'dart:convert';

enum EventStatus { upcoming, ongoing, completed, cancelled }

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String organizerId;
  final String organizerName;
  final EventStatus status;
  final int maxAttendees;
  final List<String> attendeeIds;
  final List<String> tags;
  final String? imageUrl;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.organizerId,
    required this.organizerName,
    required this.status,
    required this.maxAttendees,
    required this.attendeeIds,
    required this.tags,
    this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'status': status.toString(),
      'maxAttendees': maxAttendees,
      'attendeeIds': jsonEncode(attendeeIds),
      'tags': jsonEncode(tags),
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      location: json['location'],
      organizerId: json['organizerId'],
      organizerName: json['organizerName'],
      status: EventStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      maxAttendees: json['maxAttendees'],
      attendeeIds: List<String>.from(jsonDecode(json['attendeeIds'])),
      tags: List<String>.from(jsonDecode(json['tags'])),
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    String? location,
    String? organizerId,
    String? organizerName,
    EventStatus? status,
    int? maxAttendees,
    List<String>? attendeeIds,
    List<String>? tags,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      organizerId: organizerId ?? this.organizerId,
      organizerName: organizerName ?? this.organizerName,
      status: status ?? this.status,
      maxAttendees: maxAttendees ?? this.maxAttendees,
      attendeeIds: attendeeIds ?? this.attendeeIds,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 