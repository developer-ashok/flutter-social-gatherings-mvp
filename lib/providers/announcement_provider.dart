import 'package:flutter/foundation.dart';
import 'package:social_gatherings/models/announcement.dart';
import 'package:social_gatherings/services/database_service.dart';

class AnnouncementProvider with ChangeNotifier {
  List<Announcement> _announcements = [];
  bool _isLoading = false;

  List<Announcement> get announcements => _announcements;
  bool get isLoading => _isLoading;

  List<Announcement> get importantAnnouncements {
    return _announcements.where((announcement) => announcement.isImportant).toList();
  }

  AnnouncementProvider() {
    loadAnnouncements();
  }

  Future<void> loadAnnouncements() async {
    _isLoading = true;
    notifyListeners();

    try {
      _announcements = await DatabaseService.getAnnouncements();
    } catch (e) {
      debugPrint('Error loading announcements: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createAnnouncement(Announcement announcement) async {
    try {
      await DatabaseService.createAnnouncement(announcement);
      await loadAnnouncements();
    } catch (e) {
      debugPrint('Error creating announcement: $e');
    }
  }

  Future<void> deleteAnnouncement(String id) async {
    try {
      await DatabaseService.deleteAnnouncement(id);
      await loadAnnouncements();
    } catch (e) {
      debugPrint('Error deleting announcement: $e');
    }
  }

  Announcement? getAnnouncementById(String id) {
    try {
      return _announcements.firstWhere((announcement) => announcement.id == id);
    } catch (e) {
      return null;
    }
  }
} 