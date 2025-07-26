import 'package:flutter/material.dart';
import '../../models/image_model.dart';
import 'photo_detail_screen.dart';

class PhotoGalleryScreen extends StatelessWidget {
  final List<ImageData> images = [
    ImageData(
      id: 1,
      name: 'Mountain Lake',
      color: Colors.blue,
      emoji: '🏔️',
    ),
    ImageData(
      id: 2,
      name: 'Forest Path',
      color: Colors.green,
      emoji: '🌲',
    ),
    ImageData(
      id: 3,
      name: 'Ocean Sunset',
      color: Colors.orange,
      emoji: '🌅',
    ),
    ImageData(
      id: 4,
      name: 'Desert Dunes',
      color: Colors.amber,
      emoji: '🏜️',
    ),
  ];

  PhotoGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Photo Gallery'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tap any image to see Hero animation',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final image = images[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoDetailScreen(image: image),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Hero(
                          tag: 'image_${image.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: image.color,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  image.emoji,
                                  style: TextStyle(fontSize: 48),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          image.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}