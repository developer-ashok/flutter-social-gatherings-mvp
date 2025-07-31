import 'package:flutter/foundation.dart';
import 'package:social_gatherings/models/poll.dart';
import 'package:social_gatherings/services/database_service.dart';

class PollProvider with ChangeNotifier {
  List<Poll> _polls = [];
  bool _isLoading = false;

  List<Poll> get polls => _polls;
  bool get isLoading => _isLoading;

  List<Poll> get activePolls {
    return _polls.where((poll) => poll.isActive).toList();
  }

  PollProvider() {
    loadPolls();
  }

  Future<void> loadPolls() async {
    _isLoading = true;
    notifyListeners();

    try {
      _polls = await DatabaseService.getPolls();
    } catch (e) {
      debugPrint('Error loading polls: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createPoll(Poll poll) async {
    try {
      await DatabaseService.createPoll(poll);
      await loadPolls();
    } catch (e) {
      debugPrint('Error creating poll: $e');
    }
  }

  Future<void> deletePoll(String id) async {
    try {
      await DatabaseService.deletePoll(id);
      await loadPolls();
    } catch (e) {
      debugPrint('Error deleting poll: $e');
    }
  }

  Future<void> voteInPoll(String pollId, String optionId, String userId) async {
    try {
      await DatabaseService.voteInPoll(pollId, optionId, userId);
      await loadPolls();
    } catch (e) {
      debugPrint('Error voting in poll: $e');
    }
  }

  Poll? getPollById(String id) {
    try {
      return _polls.firstWhere((poll) => poll.id == id);
    } catch (e) {
      return null;
    }
  }

  bool hasUserVoted(String pollId, String userId) {
    final poll = getPollById(pollId);
    return poll?.votedBy.contains(userId) ?? false;
  }
} 