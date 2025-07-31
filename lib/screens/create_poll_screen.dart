import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_gatherings/providers/poll_provider.dart';
import 'package:social_gatherings/providers/auth_provider.dart';
import 'package:social_gatherings/models/poll.dart';
import 'package:intl/intl.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({super.key});

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  DateTime? _expiresAt;
  bool _hasExpiry = false;

  @override
  void dispose() {
    _questionController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    if (_optionControllers.length > 2) {
      setState(() {
        _optionControllers[index].dispose();
        _optionControllers.removeAt(index);
      });
    }
  }

  Future<void> _selectExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _expiresAt = picked;
      });
    }
  }

  Future<void> _createPoll() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final currentUser = authProvider.currentUser;
      
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please log in to create a poll'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Validate that we have at least 2 options
      final validOptions = _optionControllers
          .where((controller) => controller.text.trim().isNotEmpty)
          .map((controller) => controller.text.trim())
          .toList();

      if (validOptions.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least 2 options'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Create poll options
      final pollOptions = validOptions.asMap().entries.map((entry) {
        return PollOption(
          id: 'option_${DateTime.now().millisecondsSinceEpoch}_${entry.key}',
          text: entry.value,
          votes: 0,
        );
      }).toList();

      // Create the poll
      final poll = Poll(
        id: 'poll_${DateTime.now().millisecondsSinceEpoch}',
        question: _questionController.text.trim(),
        options: pollOptions,
        createdBy: currentUser.name,
        createdAt: DateTime.now(),
        expiresAt: _hasExpiry ? _expiresAt : null,
        isActive: true,
        votedBy: [],
      );

      try {
        final pollProvider = Provider.of<PollProvider>(context, listen: false);
        await pollProvider.createPoll(poll);
        
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Poll created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error creating poll: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Poll'),
        actions: [
          TextButton(
            onPressed: _createPoll,
            child: const Text(
              'Create',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a new poll',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ask a question and let your community vote!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              
              // Question field
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: 'Poll Question',
                  hintText: 'What would you like to ask?',
                  prefixIcon: Icon(Icons.question_answer),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a question';
                  }
                  if (value.trim().length < 5) {
                    return 'Question must be at least 5 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // Options section
              Text(
                'Poll Options',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add at least 2 options for people to vote on',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              
              // Options list
              ...List.generate(_optionControllers.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _optionControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Option ${index + 1}',
                            hintText: 'Enter option ${index + 1}',
                            prefixIcon: const Icon(Icons.radio_button_unchecked),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter option ${index + 1}';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_optionControllers.length > 2)
                        IconButton(
                          onPressed: () => _removeOption(index),
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                        ),
                    ],
                  ),
                );
              }),
              
              // Add option button
              Center(
                child: TextButton.icon(
                  onPressed: _addOption,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Option'),
                ),
              ),
              const SizedBox(height: 24),
              
              // Expiry settings
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Poll Settings',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Expiry toggle
                      Row(
                        children: [
                          Checkbox(
                            value: _hasExpiry,
                            onChanged: (value) {
                              setState(() {
                                _hasExpiry = value ?? false;
                                if (!_hasExpiry) {
                                  _expiresAt = null;
                                }
                              });
                            },
                          ),
                          const Text('Set expiry date'),
                        ],
                      ),
                      
                      if (_hasExpiry) ...[
                        const SizedBox(height: 16),
                        ListTile(
                          leading: const Icon(Icons.schedule),
                          title: Text(
                            _expiresAt != null
                                ? 'Expires: ${DateFormat('MMM d, y').format(_expiresAt!)}'
                                : 'Select expiry date',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: _selectExpiryDate,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Create button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _createPoll,
                  icon: const Icon(Icons.poll),
                  label: const Text('Create Poll'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 