import 'package:flutter/material.dart';
import '../../models/image_model.dart';
import '../../utils/page_transitions.dart';
import 'gallery_detail_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  GalleryScreenState createState() => GalleryScreenState();
}

class GalleryScreenState extends State<GalleryScreen> with TickerProviderStateMixin {
  late AnimationController _staggerController;
  final List<ImageData> images = [
    ImageData(
      id: 1,
      name: 'Mountain Lake',
      description: 'A serene alpine lake surrounded by snow-capped peaks, perfect for meditation and reflection.',
      color: Colors.blue.shade600,
      emoji: '🏔️',
      location: 'Swiss Alps',
      rating: 4.8,
    ),
    ImageData(
      id: 2,
      name: 'Mystic Forest',
      description: 'Ancient forest path with towering trees and filtered sunlight creating magical atmosphere.',
      color: Colors.green.shade600,
      emoji: '🌲',
      location: 'Black Forest',
      rating: 4.6,
    ),
    ImageData(
      id: 3,
      name: 'Golden Sunset',
      description: 'Breathtaking ocean sunset with golden reflections dancing on the waves.',
      color: Colors.orange.shade600,
      emoji: '🌅',
      location: 'Maldives',
      rating: 4.9,
    ),
    ImageData(
      id: 4,
      name: 'Desert Oasis',
      description: 'Hidden oasis in the vast desert dunes, a sanctuary of life in endless sand.',
      color: Colors.amber.shade600,
      emoji: '🏜️',
      location: 'Sahara',
      rating: 4.7,
    ),
    ImageData(
      id: 5,
      name: 'Cherry Blossoms',
      description: 'Pink petals floating like snow in the gentle spring breeze.',
      color: Colors.pink.shade400,
      emoji: '🌸',
      location: 'Kyoto',
      rating: 4.9,
    ),
    ImageData(
      id: 6,
      name: 'Northern Lights',
      description: 'Dancing aurora borealis painting the night sky in ethereal colors.',
      color: Colors.purple.shade600,
      emoji: '🌌',
      location: 'Iceland',
      rating: 5.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(duration: Duration(milliseconds: 1200), vsync: this)..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Custom Hero App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Hero(
                tag: 'app_title',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'Explore Nature',
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              centerTitle: false,
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
            ),
          ),

          // Animated Grid
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final image = images[index];
                return _buildAnimatedGridItem(image, index);
              }, childCount: images.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedGridItem(ImageData image, int index) {
    return AnimatedBuilder(
      animation: _staggerController,
      builder: (context, child) {
        final animationStart = (index * 0.1).clamp(0.0, 1.0);
        final animationEnd = (animationStart + 0.3).clamp(0.0, 1.0);

        final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _staggerController,
            curve: Interval(animationStart, animationEnd, curve: Curves.easeOutBack),
          ),
        );

        return Transform.scale(
          scale: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - animation.value.clamp(0.0, 1.0))),
            child: Opacity(
              opacity: animation.value.clamp(0.0, 1.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransitions.fadeTransition(GalleryDetailScreen(image: image)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: image.color.withValues(alpha: 0.3), blurRadius: 15, offset: Offset(0, 8))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero Image with Rating Overlay
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            Hero(
                              tag: 'image_${image.id}',
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: image.color,
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [image.color, image.color.withValues(alpha: 0.8)],
                                    ),
                                  ),
                                  child: Center(child: Text(image.emoji, style: TextStyle(fontSize: 60))),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Hero(
                                tag: 'rating_${image.id}',
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 60),
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 12),
                                          SizedBox(width: 2),
                                          Text(
                                            '${image.rating}',
                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Content
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: 'title_${image.id}',
                                child: Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      image.name,
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              Hero(
                                tag: 'location_${image.id}',
                                child: Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      image.location ?? '',
                                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
