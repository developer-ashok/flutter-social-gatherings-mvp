import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_gatherings/models/user.dart';
import 'package:social_gatherings/models/event.dart';
import 'package:social_gatherings/models/poll.dart';
import 'package:social_gatherings/models/announcement.dart';

class DatabaseService {
  static Database? _database;
  static SharedPreferences? _prefs;
  static const String _databaseName = 'social_gatherings.db';
  static const int _databaseVersion = 1;

  // Check if running on web
  static bool get _isWeb => kIsWeb;

  static Future<Database?> get database async {
    if (_isWeb) return null; // Web doesn't use SQLite
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<Database?> _initDatabase() async {
    if (_isWeb) return null;
    try {
      String path = join(await getDatabasesPath(), _databaseName);
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    } catch (e) {
      print('Database initialization error: $e');
      return null;
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        profileImage TEXT,
        createdAt TEXT NOT NULL
      )
    ''');

    // Events table
    await db.execute('''
      CREATE TABLE events (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        dateTime TEXT NOT NULL,
        location TEXT NOT NULL,
        organizerId TEXT NOT NULL,
        organizerName TEXT NOT NULL,
        status TEXT NOT NULL,
        maxAttendees INTEGER NOT NULL,
        attendeeIds TEXT NOT NULL,
        tags TEXT NOT NULL,
        imageUrl TEXT,
        createdAt TEXT NOT NULL
      )
    ''');

    // Photo albums table
    await db.execute('''
      CREATE TABLE photo_albums (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        eventId TEXT NOT NULL,
        createdBy TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    // Photos table
    await db.execute('''
      CREATE TABLE photos (
        id TEXT PRIMARY KEY,
        albumId TEXT NOT NULL,
        url TEXT NOT NULL,
        caption TEXT NOT NULL,
        uploadedBy TEXT NOT NULL,
        uploadedAt TEXT NOT NULL
      )
    ''');

    // Polls table
    await db.execute('''
      CREATE TABLE polls (
        id TEXT PRIMARY KEY,
        question TEXT NOT NULL,
        createdBy TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        expiresAt TEXT,
        isActive INTEGER NOT NULL,
        votedBy TEXT NOT NULL
      )
    ''');

    // Poll options table
    await db.execute('''
      CREATE TABLE poll_options (
        id TEXT PRIMARY KEY,
        pollId TEXT NOT NULL,
        text TEXT NOT NULL,
        votes INTEGER NOT NULL
      )
    ''');

    // Announcements table
    await db.execute('''
      CREATE TABLE announcements (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        authorId TEXT NOT NULL,
        authorName TEXT NOT NULL,
        isImportant INTEGER NOT NULL,
        tags TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  // User operations
  static Future<void> createUser(User user) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final users = _getUsersFromPrefs(prefs);
      users[user.id] = user.toJson();
      await prefs.setString('users', jsonEncode(users));
    } else {
      final db = await database;
      if (db != null) {
        await db.insert('users', user.toJson());
      }
    }
  }

  static Future<User?> getUserByEmail(String email) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final users = _getUsersFromPrefs(prefs);
      for (var userData in users.values) {
        final user = User.fromJson(userData);
        if (user.email == email) return user;
      }
      return null;
    } else {
      final db = await database;
      if (db != null) {
        final List<Map<String, dynamic>> maps = await db.query(
          'users',
          where: 'email = ?',
          whereArgs: [email],
        );
        if (maps.isNotEmpty) {
          return User.fromJson(maps.first);
        }
      }
      return null;
    }
  }

  static Future<User?> getUserById(String id) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final users = _getUsersFromPrefs(prefs);
      final userData = users[id];
      return userData != null ? User.fromJson(userData) : null;
    } else {
      final db = await database;
      if (db != null) {
        final List<Map<String, dynamic>> maps = await db.query(
          'users',
          where: 'id = ?',
          whereArgs: [id],
        );
        if (maps.isNotEmpty) {
          return User.fromJson(maps.first);
        }
      }
      return null;
    }
  }

  // Event operations
  static Future<void> createEvent(Event event) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final events = _getEventsFromPrefs(prefs);
      events[event.id] = event.toJson();
      await prefs.setString('events', jsonEncode(events));
    } else {
      final db = await database;
      if (db != null) {
        await db.insert('events', event.toJson());
      }
    }
  }

  static Future<List<Event>> getEvents() async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final events = _getEventsFromPrefs(prefs);
      return events.values.map((e) => Event.fromJson(e)).toList();
    } else {
      final db = await database;
      if (db != null) {
        final List<Map<String, dynamic>> maps = await db.query('events');
        return List.generate(maps.length, (i) => Event.fromJson(maps[i]));
      }
      return [];
    }
  }

  static Future<void> updateEvent(Event event) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final events = _getEventsFromPrefs(prefs);
      events[event.id] = event.toJson();
      await prefs.setString('events', jsonEncode(events));
    } else {
      final db = await database;
      if (db != null) {
        await db.update(
          'events',
          event.toJson(),
          where: 'id = ?',
          whereArgs: [event.id],
        );
      }
    }
  }

  static Future<void> deleteEvent(String id) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final events = _getEventsFromPrefs(prefs);
      events.remove(id);
      await prefs.setString('events', jsonEncode(events));
    } else {
      final db = await database;
      if (db != null) {
        await db.delete(
          'events',
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    }
  }

  // Poll operations
  static Future<void> createPoll(Poll poll) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final polls = _getPollsFromPrefs(prefs);
      polls[poll.id] = poll.toJson();
      await prefs.setString('polls', jsonEncode(polls));
    } else {
      final db = await database;
      if (db != null) {
        await db.insert('polls', poll.toJson());
        for (var option in poll.options) {
          await db.insert('poll_options', option.toJson());
        }
      }
    }
  }

  static Future<List<Poll>> getPolls() async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final polls = _getPollsFromPrefs(prefs);
      return polls.values.map((p) => Poll.fromJson(p)).toList();
    } else {
      final db = await database;
      if (db != null) {
        final List<Map<String, dynamic>> pollMaps = await db.query('polls');
        List<Poll> polls = [];
        for (var pollMap in pollMaps) {
          final List<Map<String, dynamic>> optionMaps = await db.query(
            'poll_options',
            where: 'pollId = ?',
            whereArgs: [pollMap['id']],
          );
          final options = List.generate(
            optionMaps.length,
            (i) => PollOption.fromJson(optionMaps[i]),
          );
          // Create a new Poll instance with the options
          final poll = Poll(
            id: pollMap['id'],
            question: pollMap['question'],
            options: options,
            createdBy: pollMap['createdBy'],
            createdAt: DateTime.parse(pollMap['createdAt']),
            expiresAt: pollMap['expiresAt'] != null 
                ? DateTime.parse(pollMap['expiresAt']) 
                : null,
            isActive: pollMap['isActive'] == 1,
            votedBy: List<String>.from(jsonDecode(pollMap['votedBy'])),
          );
          polls.add(poll);
        }
        return polls;
      }
      return [];
    }
  }

  static Future<void> updatePoll(Poll poll) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final polls = _getPollsFromPrefs(prefs);
      polls[poll.id] = poll.toJson();
      await prefs.setString('polls', jsonEncode(polls));
    } else {
      final db = await database;
      if (db != null) {
        await db.update(
          'polls',
          poll.toJson(),
          where: 'id = ?',
          whereArgs: [poll.id],
        );
        // Update options
        await db.delete(
          'poll_options',
          where: 'pollId = ?',
          whereArgs: [poll.id],
        );
        for (var option in poll.options) {
          await db.insert('poll_options', option.toJson());
        }
      }
    }
  }

  static Future<void> deletePoll(String id) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final polls = _getPollsFromPrefs(prefs);
      polls.remove(id);
      await prefs.setString('polls', jsonEncode(polls));
    } else {
      final db = await database;
      if (db != null) {
        await db.delete(
          'polls',
          where: 'id = ?',
          whereArgs: [id],
        );
        await db.delete(
          'poll_options',
          where: 'pollId = ?',
          whereArgs: [id],
        );
      }
    }
  }

  static Future<void> voteInPoll(String pollId, String optionId, String userId) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final polls = _getPollsFromPrefs(prefs);
      final pollData = polls[pollId];
      if (pollData != null) {
        final poll = Poll.fromJson(pollData);
        final votedBy = List<String>.from(poll.votedBy);
        if (!votedBy.contains(userId)) {
          votedBy.add(userId);
          // Update the poll with new votedBy list
          final updatedPoll = Poll(
            id: poll.id,
            question: poll.question,
            options: poll.options.map((option) {
              if (option.id == optionId) {
                return PollOption(
                  id: option.id,
                  text: option.text,
                  votes: option.votes + 1,
                );
              }
              return option;
            }).toList(),
            createdBy: poll.createdBy,
            createdAt: poll.createdAt,
            expiresAt: poll.expiresAt,
            isActive: poll.isActive,
            votedBy: votedBy,
          );
          polls[pollId] = updatedPoll.toJson();
          await prefs.setString('polls', jsonEncode(polls));
        }
      }
    } else {
      final db = await database;
      if (db != null) {
        // Update poll option votes
        await db.rawUpdate('''
          UPDATE poll_options 
          SET votes = votes + 1 
          WHERE id = ?
        ''', [optionId]);
        
        // Add user to votedBy list
        final poll = await db.query('polls', where: 'id = ?', whereArgs: [pollId]);
        if (poll.isNotEmpty) {
          final votedBy = List<String>.from(jsonDecode(poll.first['votedBy'] as String));
          if (!votedBy.contains(userId)) {
            votedBy.add(userId);
            await db.update('polls', 
              {'votedBy': jsonEncode(votedBy)}, 
              where: 'id = ?',
              whereArgs: [pollId]
            );
          }
        }
      }
    }
  }

  // Announcement operations
  static Future<void> createAnnouncement(Announcement announcement) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final announcements = _getAnnouncementsFromPrefs(prefs);
      announcements[announcement.id] = announcement.toJson();
      await prefs.setString('announcements', jsonEncode(announcements));
    } else {
      final db = await database;
      if (db != null) {
        await db.insert('announcements', announcement.toJson());
      }
    }
  }

  static Future<List<Announcement>> getAnnouncements() async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final announcements = _getAnnouncementsFromPrefs(prefs);
      return announcements.values.map((a) => Announcement.fromJson(a)).toList();
    } else {
      final db = await database;
      if (db != null) {
        final List<Map<String, dynamic>> maps = await db.query('announcements');
        return List.generate(maps.length, (i) => Announcement.fromJson(maps[i]));
      }
      return [];
    }
  }

  static Future<void> updateAnnouncement(Announcement announcement) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final announcements = _getAnnouncementsFromPrefs(prefs);
      announcements[announcement.id] = announcement.toJson();
      await prefs.setString('announcements', jsonEncode(announcements));
    } else {
      final db = await database;
      if (db != null) {
        await db.update(
          'announcements',
          announcement.toJson(),
          where: 'id = ?',
          whereArgs: [announcement.id],
        );
      }
    }
  }

  static Future<void> deleteAnnouncement(String id) async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      final announcements = _getAnnouncementsFromPrefs(prefs);
      announcements.remove(id);
      await prefs.setString('announcements', jsonEncode(announcements));
    } else {
      final db = await database;
      if (db != null) {
        await db.delete(
          'announcements',
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    }
  }

  // Helper methods for SharedPreferences
  static Map<String, dynamic> _getUsersFromPrefs(SharedPreferences prefs) {
    final usersString = prefs.getString('users') ?? '{}';
    return Map<String, dynamic>.from(jsonDecode(usersString));
  }

  static Map<String, dynamic> _getEventsFromPrefs(SharedPreferences prefs) {
    final eventsString = prefs.getString('events') ?? '{}';
    return Map<String, dynamic>.from(jsonDecode(eventsString));
  }

  static Map<String, dynamic> _getPollsFromPrefs(SharedPreferences prefs) {
    final pollsString = prefs.getString('polls') ?? '{}';
    return Map<String, dynamic>.from(jsonDecode(pollsString));
  }

  static Map<String, dynamic> _getAnnouncementsFromPrefs(SharedPreferences prefs) {
    final announcementsString = prefs.getString('announcements') ?? '{}';
    return Map<String, dynamic>.from(jsonDecode(announcementsString));
  }

  // Initialize demo data
  static Future<void> initializeDemoData() async {
    if (_isWeb) {
      final prefs = await DatabaseService.prefs;
      
      // Check if demo data already exists
      final hasDemoData = prefs.getBool('demo_data_initialized') ?? false;
      if (hasDemoData) return;
      
      // Create demo events
      final demoEvents = {
        'event1': {
          'id': 'event1',
          'title': 'Summer BBQ Party',
          'description': 'Join us for a fun summer BBQ with friends and family!',
          'dateTime': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
          'location': 'Central Park',
          'organizerId': 'user1',
          'organizerName': 'John Doe',
          'status': 'upcoming',
          'maxAttendees': 50,
          'attendeeIds': jsonEncode(['user1', 'user2']),
          'tags': jsonEncode(['BBQ', 'Summer', 'Outdoor']),
          'imageUrl': null,
          'createdAt': DateTime.now().toIso8601String(),
        },
        'event2': {
          'id': 'event2',
          'title': 'Game Night',
          'description': 'Board games and card games night!',
          'dateTime': DateTime.now().add(const Duration(days: 14)).toIso8601String(),
          'location': 'Community Center',
          'organizerId': 'user2',
          'organizerName': 'Jane Smith',
          'status': 'upcoming',
          'maxAttendees': 20,
          'attendeeIds': jsonEncode(['user1']),
          'tags': jsonEncode(['Games', 'Indoor', 'Fun']),
          'imageUrl': null,
          'createdAt': DateTime.now().toIso8601String(),
        },
      };
      
      // Create demo polls
      final demoPolls = {
        'poll1': {
          'id': 'poll1',
          'question': 'What food should we serve at the BBQ?',
          'options': [
            {
              'id': 'option1',
              'text': 'Burgers and Hot Dogs',
              'votes': 5,
            },
            {
              'id': 'option2',
              'text': 'Pizza',
              'votes': 3,
            },
            {
              'id': 'option3',
              'text': 'Tacos',
              'votes': 2,
            },
          ],
          'createdBy': 'user1',
          'createdAt': DateTime.now().toIso8601String(),
          'expiresAt': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
          'isActive': 1,
          'votedBy': jsonEncode(['user1']),
        },
      };
      
      // Create demo announcements
      final demoAnnouncements = {
        'announcement1': {
          'id': 'announcement1',
          'title': 'Welcome to Social Gatherings!',
          'content': 'We\'re excited to have you join our community. Start creating and joining events!',
          'authorId': 'user1',
          'authorName': 'John Doe',
          'isImportant': 1,
          'tags': jsonEncode(['Welcome', 'Community']),
          'createdAt': DateTime.now().toIso8601String(),
        },
        'announcement2': {
          'id': 'announcement2',
          'title': 'New Feature: Photo Albums',
          'content': 'You can now create photo albums for your events and share memories!',
          'authorId': 'user2',
          'authorName': 'Jane Smith',
          'isImportant': 0,
          'tags': jsonEncode(['Feature', 'Photos']),
          'createdAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        },
      };
      
      // Save demo data
      await prefs.setString('events', jsonEncode(demoEvents));
      await prefs.setString('polls', jsonEncode(demoPolls));
      await prefs.setString('announcements', jsonEncode(demoAnnouncements));
      await prefs.setBool('demo_data_initialized', true);
    } else {
      // For mobile, check if demo data exists
      final db = await database;
      if (db != null) {
        final events = await db.query('events');
        if (events.isEmpty) {
          await _insertDemoData(db);
        }
      }
    }
  }

  static Future<void> _insertDemoData(Database db) async {
    // Demo events
    final demoEvents = [
      {
        'id': 'event1',
        'title': 'Summer BBQ Party',
        'description': 'Join us for a fun summer BBQ with friends and family!',
        'dateTime': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
        'location': 'Central Park',
        'organizerId': 'user1',
        'organizerName': 'John Doe',
        'status': 'upcoming',
        'maxAttendees': 50,
        'attendeeIds': jsonEncode(['user1', 'user2']),
        'tags': jsonEncode(['BBQ', 'Summer', 'Outdoor']),
        'imageUrl': null,
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'event2',
        'title': 'Game Night',
        'description': 'Board games and card games night!',
        'dateTime': DateTime.now().add(const Duration(days: 14)).toIso8601String(),
        'location': 'Community Center',
        'organizerId': 'user2',
        'organizerName': 'Jane Smith',
        'status': 'upcoming',
        'maxAttendees': 20,
        'attendeeIds': jsonEncode(['user1']),
        'tags': jsonEncode(['Games', 'Indoor', 'Fun']),
        'imageUrl': null,
        'createdAt': DateTime.now().toIso8601String(),
      },
    ];

    for (final event in demoEvents) {
      await db.insert('events', event);
    }

    // Demo polls
    final demoPolls = [
      {
        'id': 'poll1',
        'question': 'What food should we serve at the BBQ?',
        'createdBy': 'user1',
        'createdAt': DateTime.now().toIso8601String(),
        'expiresAt': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
        'isActive': 1,
        'votedBy': jsonEncode(['user1']),
      },
    ];

    for (final poll in demoPolls) {
      await db.insert('polls', poll);
    }

    // Demo poll options
    final demoPollOptions = [
      {
        'id': 'option1',
        'pollId': 'poll1',
        'text': 'Burgers and Hot Dogs',
        'votes': 5,
      },
      {
        'id': 'option2',
        'pollId': 'poll1',
        'text': 'Pizza',
        'votes': 3,
      },
      {
        'id': 'option3',
        'pollId': 'poll1',
        'text': 'Tacos',
        'votes': 2,
      },
    ];

    for (final option in demoPollOptions) {
      await db.insert('poll_options', option);
    }

    // Demo announcements
    final demoAnnouncements = [
      {
        'id': 'announcement1',
        'title': 'Welcome to Social Gatherings!',
        'content': 'We\'re excited to have you join our community. Start creating and joining events!',
        'authorId': 'user1',
        'authorName': 'John Doe',
        'isImportant': 1,
        'tags': jsonEncode(['Welcome', 'Community']),
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'announcement2',
        'title': 'New Feature: Photo Albums',
        'content': 'You can now create photo albums for your events and share memories!',
        'authorId': 'user2',
        'authorName': 'Jane Smith',
        'isImportant': 0,
        'tags': jsonEncode(['Feature', 'Photos']),
        'createdAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      },
    ];

    for (final announcement in demoAnnouncements) {
      await db.insert('announcements', announcement);
    }
  }
} 