import 'package:flutter/material.dart';
import 'package:hero_animation_tip/models/image_model.dart';

class PhotoGalleryScreen extends StatelessWidget {
  final List<ImageData> images = [
    ImageData(id: 1, name: 'Mountain Lake', color: Colors.blue, emoji: '🏔️'),
    ImageData(id: 2, name: 'Forest Path', color: Colors.green, emoji: '🌲'),
    ImageData(id: 3, name: 'Ocean Sunset', color: Colors.orange, emoji: '🌅'),
    ImageData(id: 4, name: 'Desert Dunes', color: Colors.amber, emoji: '🏜️'),
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
            Text('Tap any image to see Hero animation', style: TextStyle(color: Colors.blue[700], fontSize: 14)),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(image: image)));
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
                                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                              ),
                              child: Center(child: Text(image.emoji, style: TextStyle(fontSize: 48))),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          image.name,
                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
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

class DetailScreen extends StatelessWidget {
  final ImageData image;

  const DetailScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Detail Screen'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'image_${image.id}',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: image.color,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: Center(child: Text(image.emoji, style: TextStyle(fontSize: 96))),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              image.name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            SizedBox(height: 16),
            Text(
              'This is the detail view for ${image.name}. The image above smoothly animated from the list screen using Hero animation.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Code:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Hero(tag: 'image_${image.id}', child: Image(...))",
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      color: Colors.green[700],
                      backgroundColor: Colors.green[50],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
