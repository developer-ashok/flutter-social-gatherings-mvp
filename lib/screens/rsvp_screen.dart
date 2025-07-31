import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_gatherings/providers/event_provider.dart';
import 'package:social_gatherings/providers/auth_provider.dart';
import 'package:social_gatherings/models/event.dart';
import 'package:intl/intl.dart';

class RSVPScreen extends StatefulWidget {
  const RSVPScreen({super.key});

  @override
  State<RSVPScreen> createState() => _RSVPScreenState();
}

class _RSVPScreenState extends State<RSVPScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSVP'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming Events'),
            Tab(text: 'My RSVPs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingEventsTab(),
          _buildMyRSVPsTab(),
        ],
      ),
    );
  }

  Widget _buildUpcomingEventsTab() {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) {
        if (eventProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final upcomingEvents = eventProvider.upcomingEvents;

        if (upcomingEvents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No upcoming events',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Check back later for new events',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: upcomingEvents.length,
          itemBuilder: (context, index) {
            final event = upcomingEvents[index];
            return _buildEventCard(event, false);
          },
        );
      },
    );
  }

  Widget _buildMyRSVPsTab() {
    return Consumer2<EventProvider, AuthProvider>(
      builder: (context, eventProvider, authProvider, child) {
        if (eventProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final currentUser = authProvider.currentUser;
        if (currentUser == null) {
          return const Center(child: Text('Please log in'));
        }

        final myEvents = eventProvider.events.where((event) {
          return event.attendeeIds.contains(currentUser.id);
        }).toList();

        if (myEvents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No RSVPs yet',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'RSVP to events to see them here',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: myEvents.length,
          itemBuilder: (context, index) {
            final event = myEvents[index];
            return _buildEventCard(event, true);
          },
        );
      },
    );
  }

  Widget _buildEventCard(Event event, bool isRSVPd) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.event,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        event.location,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isRSVPd)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'RSVP\'d',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              event.description,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM d, y • h:mm a').format(event.dateTime),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.people,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${event.attendeeIds.length}/${event.maxAttendees}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showEventDetails(event);
                    },
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      final currentUser = authProvider.currentUser;
                      final isAttending = currentUser != null && 
                          event.attendeeIds.contains(currentUser.id);

                      return ElevatedButton(
                        onPressed: () {
                          _handleRSVP(event, isAttending);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAttending ? Colors.red : null,
                        ),
                        child: Text(isAttending ? 'Cancel RSVP' : 'RSVP'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleRSVP(Event event, bool isAttending) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isAttending ? 'Cancel RSVP' : 'Confirm RSVP'),
        content: Text(
          isAttending 
              ? 'Are you sure you want to cancel your RSVP for "${event.title}"?'
              : 'Are you sure you want to RSVP for "${event.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual RSVP functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isAttending 
                        ? 'RSVP cancelled successfully!'
                        : 'RSVP confirmed successfully!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(isAttending ? 'Cancel RSVP' : 'Confirm'),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(Event event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                _buildDetailRow(Icons.location_on, 'Location', event.location),
                _buildDetailRow(Icons.access_time, 'Date & Time', 
                    DateFormat('EEEE, MMMM d, y • h:mm a').format(event.dateTime)),
                _buildDetailRow(Icons.person, 'Organizer', event.organizerName),
                _buildDetailRow(Icons.people, 'Attendees', 
                    '${event.attendeeIds.length}/${event.maxAttendees}'),
                const SizedBox(height: 20),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    final currentUser = authProvider.currentUser;
                    final isAttending = currentUser != null && 
                        event.attendeeIds.contains(currentUser.id);

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _handleRSVP(event, isAttending);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAttending ? Colors.red : null,
                        ),
                        child: Text(isAttending ? 'Cancel RSVP' : 'RSVP'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 