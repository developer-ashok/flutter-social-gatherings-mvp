import 'package:flutter/foundation.dart';
import 'package:social_gatherings/models/event.dart';
import 'package:social_gatherings/services/database_service.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [];
  bool _isLoading = false;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;

  List<Event> get upcomingEvents {
    final now = DateTime.now();
    return _events.where((event) => event.dateTime.isAfter(now)).toList();
  }

  List<Event> get pastEvents {
    final now = DateTime.now();
    return _events.where((event) => event.dateTime.isBefore(now)).toList();
  }

  EventProvider() {
    loadEvents();
  }

  Future<void> loadEvents() async {
    _isLoading = true;
    notifyListeners();

    try {
      _events = await DatabaseService.getEvents();
    } catch (e) {
      debugPrint('Error loading events: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createEvent(Event event) async {
    try {
      await DatabaseService.createEvent(event);
      await loadEvents();
    } catch (e) {
      debugPrint('Error creating event: $e');
    }
  }

  Future<void> updateEvent(Event event) async {
    try {
      await DatabaseService.updateEvent(event);
      await loadEvents();
    } catch (e) {
      debugPrint('Error updating event: $e');
    }
  }

  Event? getEventById(String id) {
    try {
      return _events.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Event> getEventsByDate(DateTime date) {
    return _events.where((event) {
      return event.dateTime.year == date.year &&
          event.dateTime.month == date.month &&
          event.dateTime.day == date.day;
    }).toList();
  }
} 