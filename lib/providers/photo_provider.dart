import 'package:flutter/foundation.dart';
import 'package:social_gatherings/models/photo_album.dart';

class PhotoProvider with ChangeNotifier {
  List<PhotoAlbum> _albums = [];
  bool _isLoading = false;

  List<PhotoAlbum> get albums => _albums;
  bool get isLoading => _isLoading;

  PhotoProvider() {
    _loadDemoAlbums();
  }

  void _loadDemoAlbums() {
    _isLoading = true;
    notifyListeners();

    // Demo photo albums
    _albums = [
      PhotoAlbum(
        id: 'album1',
        title: 'Summer BBQ 2024',
        description: 'Memories from our amazing summer BBQ party',
        eventId: 'event1',
        createdBy: 'user1',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        photos: [
          Photo(
            id: 'photo1',
            url: 'https://picsum.photos/400/300?random=1',
            caption: 'Grilling in the sun',
            uploadedBy: 'user1',
            uploadedAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
          Photo(
            id: 'photo2',
            url: 'https://picsum.photos/400/300?random=2',
            caption: 'Group photo',
            uploadedBy: 'user2',
            uploadedAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
          Photo(
            id: 'photo3',
            url: 'https://picsum.photos/400/300?random=3',
            caption: 'Delicious food',
            uploadedBy: 'user1',
            uploadedAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
        ],
      ),
      PhotoAlbum(
        id: 'album2',
        title: 'Game Night Memories',
        description: 'Fun times playing board games',
        eventId: 'event2',
        createdBy: 'user2',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        photos: [
          Photo(
            id: 'photo4',
            url: 'https://picsum.photos/400/300?random=4',
            caption: 'Monopoly championship',
            uploadedBy: 'user2',
            uploadedAt: DateTime.now().subtract(const Duration(days: 10)),
          ),
          Photo(
            id: 'photo5',
            url: 'https://picsum.photos/400/300?random=5',
            caption: 'Card games',
            uploadedBy: 'user1',
            uploadedAt: DateTime.now().subtract(const Duration(days: 10)),
          ),
        ],
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createAlbum(PhotoAlbum album) async {
    _albums.add(album);
    notifyListeners();
  }

  Future<void> addPhotoToAlbum(String albumId, Photo photo) async {
    final albumIndex = _albums.indexWhere((album) => album.id == albumId);
    if (albumIndex != -1) {
      final updatedPhotos = List<Photo>.from(_albums[albumIndex].photos);
      updatedPhotos.add(photo);
      
      final updatedAlbum = PhotoAlbum(
        id: _albums[albumIndex].id,
        title: _albums[albumIndex].title,
        description: _albums[albumIndex].description,
        eventId: _albums[albumIndex].eventId,
        createdBy: _albums[albumIndex].createdBy,
        createdAt: _albums[albumIndex].createdAt,
        photos: updatedPhotos,
      );
      
      _albums[albumIndex] = updatedAlbum;
      notifyListeners();
    }
  }

  PhotoAlbum? getAlbumById(String id) {
    try {
      return _albums.firstWhere((album) => album.id == id);
    } catch (e) {
      return null;
    }
  }

  List<PhotoAlbum> getAlbumsByEvent(String eventId) {
    return _albums.where((album) => album.eventId == eventId).toList();
  }
} 