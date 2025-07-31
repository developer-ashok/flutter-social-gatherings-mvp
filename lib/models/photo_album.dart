class PhotoAlbum {
  final String id;
  final String title;
  final String description;
  final String eventId;
  final String createdBy;
  final DateTime createdAt;
  final List<Photo> photos;

  PhotoAlbum({
    required this.id,
    required this.title,
    required this.description,
    required this.eventId,
    required this.createdBy,
    required this.createdAt,
    required this.photos,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'eventId': eventId,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'photos': photos.map((photo) => photo.toJson()).toList(),
    };
  }

  factory PhotoAlbum.fromJson(Map<String, dynamic> json) {
    return PhotoAlbum(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      eventId: json['eventId'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      photos: (json['photos'] as List)
          .map((photo) => Photo.fromJson(photo))
          .toList(),
    );
  }
}

class Photo {
  final String id;
  final String url;
  final String caption;
  final String uploadedBy;
  final DateTime uploadedAt;

  Photo({
    required this.id,
    required this.url,
    required this.caption,
    required this.uploadedBy,
    required this.uploadedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'caption': caption,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['url'],
      caption: json['caption'],
      uploadedBy: json['uploadedBy'],
      uploadedAt: DateTime.parse(json['uploadedAt']),
    );
  }
} 