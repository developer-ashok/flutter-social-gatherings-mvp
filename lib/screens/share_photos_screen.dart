import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_gatherings/providers/photo_provider.dart';
import 'package:social_gatherings/providers/auth_provider.dart';
import 'package:social_gatherings/models/photo_album.dart';
import 'package:intl/intl.dart';

class SharePhotosScreen extends StatefulWidget {
  const SharePhotosScreen({super.key});

  @override
  State<SharePhotosScreen> createState() => _SharePhotosScreenState();
}

class _SharePhotosScreenState extends State<SharePhotosScreen> {
  final _albumTitleController = TextEditingController();
  final _albumDescriptionController = TextEditingController();
  final _photoCaptionController = TextEditingController();
  
  bool _showCreateAlbum = false;
  PhotoAlbum? _selectedAlbum;

  @override
  void dispose() {
    _albumTitleController.dispose();
    _albumDescriptionController.dispose();
    _photoCaptionController.dispose();
    super.dispose();
  }

  Future<void> _createAlbum() async {
    if (_albumTitleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an album title'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in to create an album'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final album = PhotoAlbum(
      id: 'album_${DateTime.now().millisecondsSinceEpoch}',
      title: _albumTitleController.text.trim(),
      description: _albumDescriptionController.text.trim(),
      eventId: '', // For now, not linked to specific event
      createdBy: currentUser.name,
      createdAt: DateTime.now(),
      photos: [], // Start with empty photos list
    );

    try {
      final photoProvider = Provider.of<PhotoProvider>(context, listen: false);
      await photoProvider.createAlbum(album);

      setState(() {
        _showCreateAlbum = false;
        _selectedAlbum = album;
      });

      _albumTitleController.clear();
      _albumDescriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Album created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating album: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _addPhotoToAlbum() async {
    if (_selectedAlbum == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an album first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_photoCaptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a caption for the photo'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in to add photos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // For demo purposes, we'll use a placeholder image URL
    // In a real app, you'd implement image picker and upload functionality
    final photo = Photo(
      id: 'photo_${DateTime.now().millisecondsSinceEpoch}',
      url: 'https://picsum.photos/400/300?random=${DateTime.now().millisecondsSinceEpoch}',
      caption: _photoCaptionController.text.trim(),
      uploadedBy: currentUser.name,
      uploadedAt: DateTime.now(),
    );

    try {
      final photoProvider = Provider.of<PhotoProvider>(context, listen: false);
      await photoProvider.addPhotoToAlbum(_selectedAlbum!.id, photo);

      _photoCaptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Photos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate),
            onPressed: () {
              if (_selectedAlbum != null) {
                _showAddPhotoDialog();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select an album first'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Consumer<PhotoProvider>(
        builder: (context, photoProvider, child) {
          if (photoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Share your memories',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create albums and share photos with your community',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Create Album Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.create_new_folder,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Create New Album',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        if (!_showCreateAlbum) ...[
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _showCreateAlbum = true;
                              });
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Create Album'),
                          ),
                        ] else ...[
                          TextFormField(
                            controller: _albumTitleController,
                            decoration: const InputDecoration(
                              labelText: 'Album Title',
                              hintText: 'Enter album title',
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _albumDescriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description (Optional)',
                              hintText: 'Describe this album',
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _createAlbum,
                                  child: const Text('Create'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showCreateAlbum = false;
                                      _albumTitleController.clear();
                                      _albumDescriptionController.clear();
                                    });
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Select Album Section
                if (photoProvider.albums.isNotEmpty) ...[
                  Text(
                    'Select Album',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: photoProvider.albums.length,
                      itemBuilder: (context, index) {
                        final album = photoProvider.albums[index];
                        final isSelected = _selectedAlbum?.id == album.id;
                        
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 12),
                          child: Card(
                            color: isSelected 
                                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                                : null,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedAlbum = album;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.photo_album,
                                          color: isSelected 
                                              ? Theme.of(context).colorScheme.primary
                                              : Colors.grey[600],
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            album.title,
                                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: isSelected 
                                                  ? Theme.of(context).colorScheme.primary
                                                  : null,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      album.description.isNotEmpty 
                                          ? album.description 
                                          : 'No description',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Created by ${album.createdBy}',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey[500],
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Add Photo Section
                if (_selectedAlbum != null) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Add Photo to "${_selectedAlbum!.title}"',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _photoCaptionController,
                            decoration: const InputDecoration(
                              labelText: 'Photo Caption',
                              hintText: 'Describe this photo',
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _addPhotoToAlbum,
                              icon: const Icon(Icons.add_photo_alternate),
                              label: const Text('Add Photo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                // Albums List
                if (photoProvider.albums.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  Text(
                    'Your Albums',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: photoProvider.albums.length,
                    itemBuilder: (context, index) {
                      final album = photoProvider.albums[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            child: Icon(
                              Icons.photo_album,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          title: Text(
                            album.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (album.description.isNotEmpty)
                                Text(
                                  album.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              Text(
                                'Created by ${album.createdBy} • ${DateFormat('MMM d, y').format(album.createdAt)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Navigate to album detail screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Viewing album: ${album.title}'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddPhotoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Photo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _photoCaptionController,
              decoration: const InputDecoration(
                labelText: 'Photo Caption',
                hintText: 'Describe this photo',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _addPhotoToAlbum();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
} 