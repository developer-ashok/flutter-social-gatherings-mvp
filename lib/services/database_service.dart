import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:social_gatherings/models/user.dart';
import 'package:social_gatherings/models/event.dart';

import 'package:social_gatherings/models/poll.dart';
import 'package:social_gatherings/models/announcement.dart';

class DatabaseService {
  static Database? _database;
  static const String _databaseName = 'social_gatherings.db';
  static const int _databaseVersion = 1;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
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
        createdAt TEXT NOT NULL,
        isImportant INTEGER NOT NULL,
        tags TEXT NOT NULL
      )
    ''');

    // Insert demo data
    await _insertDemoData(db);
  }

  static Future<void> _insertDemoData(Database db) async {
    // Demo users
    final demoUsers = [
      {
        'id': 'user1',
        'name': 'John Doe',
        'email': 'john@example.com',
        'profileImage': null,
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'user2',
        'name': 'Jane Smith',
        'email': 'jane@example.com',
        'profileImage': null,
        'createdAt': DateTime.now().toIso8601String(),
      },
    ];

    for (final user in demoUsers) {
      await db.insert('users', user);
    }

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
        'status': 'EventStatus.upcoming',
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
        'status': 'EventStatus.upcoming',
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
        'createdAt': DateTime.now().toIso8601String(),
        'isImportant': 1,
        'tags': jsonEncode(['Welcome', 'Community']),
      },
      {
        'id': 'announcement2',
        'title': 'New Feature: Photo Albums',
        'content': 'You can now create photo albums for your events and share memories!',
        'authorId': 'user2',
        'authorName': 'Jane Smith',
        'createdAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'isImportant': 0,
        'tags': jsonEncode(['Feature', 'Photos']),
      },
    ];

    for (final announcement in demoAnnouncements) {
      await db.insert('announcements', announcement);
    }
  }

  // User operations
  static Future<User?> getUser(String id) async {
    final db = await database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    }
    return null;
  }

  static Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query('users', where: 'email = ?', whereArgs: [email]);
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    }
    return null;
  }

  static Future<void> createUser(User user) async {
    final db = await database;
    await db.insert('users', user.toJson());
  }

  // Event operations
  static Future<List<Event>> getEvents() async {
    final db = await database;
    final maps = await db.query('events', orderBy: 'dateTime ASC');
    return maps.map((map) => Event.fromJson(map)).toList();
  }

  static Future<Event?> getEvent(String id) async {
    final db = await database;
    final maps = await db.query('events', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Event.fromJson(maps.first);
    }
    return null;
  }

  static Future<void> createEvent(Event event) async {
    final db = await database;
    await db.insert('events', event.toJson());
  }

  static Future<void> updateEvent(Event event) async {
    final db = await database;
    await db.update('events', event.toJson(), where: 'id = ?', whereArgs: [event.id]);
  }

  // Poll operations
  static Future<List<Poll>> getPolls() async {
    final db = await database;
    final maps = await db.query('polls', orderBy: 'createdAt DESC');
    final polls = <Poll>[];
    
    for (final map in maps) {
      final options = await db.query('poll_options', where: 'pollId = ?', whereArgs: [map['id']]);
      final pollOptions = options.map((option) => PollOption.fromJson(option)).toList();
      
      // Create poll with options
      final poll = Poll(
        id: map['id'] as String,
        question: map['question'] as String,
        options: pollOptions,
        createdBy: map['createdBy'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
        expiresAt: map['expiresAt'] != null ? DateTime.parse(map['expiresAt'] as String) : null,
        isActive: (map['isActive'] as int) == 1,
        votedBy: List<String>.from(jsonDecode(map['votedBy'] as String)),
      );
      polls.add(poll);
    }
    
    return polls;
  }

  static Future<void> createPoll(Poll poll) async {
    final db = await database;
    await db.insert('polls', poll.toJson());
    
    for (final option in poll.options) {
      await db.insert('poll_options', {
        ...option.toJson(),
        'pollId': poll.id,
      });
    }
  }

  static Future<void> deletePoll(String id) async {
    final db = await database;
    // Delete poll options first (foreign key constraint)
    await db.delete('poll_options', where: 'pollId = ?', whereArgs: [id]);
    // Then delete the poll
    await db.delete('polls', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> voteInPoll(String pollId, String optionId, String userId) async {
    final db = await database;
    
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

  // Announcement operations
  static Future<List<Announcement>> getAnnouncements() async {
    final db = await database;
    final maps = await db.query('announcements', orderBy: 'createdAt DESC');
    return maps.map((map) => Announcement.fromJson(map)).toList();
  }

  static Future<void> createAnnouncement(Announcement announcement) async {
    final db = await database;
    await db.insert('announcements', announcement.toJson());
  }

  static Future<void> deleteAnnouncement(String id) async {
    final db = await database;
    await db.delete('announcements', where: 'id = ?', whereArgs: [id]);
  }
} 