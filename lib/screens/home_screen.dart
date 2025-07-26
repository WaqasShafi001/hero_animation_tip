import 'package:flutter/material.dart';
import 'basic_hero/photo_gallery_screen.dart';
import 'advanced_hero/gallery_screen.dart';
import '../utils/page_transitions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _cardController;
  late Animation<double> _logoAnimation;
  late Animation<double> _card1Animation;
  late Animation<double> _card2Animation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);

    _cardController = AnimationController(duration: Duration(milliseconds: 1200), vsync: this);

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.elasticOut));

    _card1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _card2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: Interval(0.3, 0.9, curve: Curves.easeOutBack),
      ),
    );

    _logoController.forward();
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) _cardController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 40),

              // Animated Logo and Title
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _logoAnimation.value.clamp(0.0, 1.0),
                    child: Opacity(
                      opacity: _logoAnimation.value.clamp(0.0, 1.0),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue.shade400, Colors.purple.shade400],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.blue.withValues(alpha: 0.3), blurRadius: 20, offset: Offset(0, 10)),
                              ],
                            ),
                            child: Center(child: Text('🚀', style: TextStyle(fontSize: 40))),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Hero Animations',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Showcase Flutter\'s powerful Hero widgets',
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              Spacer(),

              // Basic Hero Animation Card
              _buildAnimatedCard(
                animation: _card1Animation,
                onTap: () {
                  Navigator.push(context, PageTransitions.slideFromRight(PhotoGalleryScreen()));
                },
                gradient: [Colors.blue.shade400, Colors.blue.shade600],
                shadowColor: Colors.blue.withValues(alpha: 0.3),
                icon: '✨',
                title: 'Basic Hero Animation',
                subtitle: 'Simple image transitions between screens',
              ),

              SizedBox(height: 20),

              // Advanced Hero Animation Card
              _buildAnimatedCard(
                animation: _card2Animation,
                onTap: () {
                  Navigator.push(context, PageTransitions.slideFromRight(GalleryScreen()));
                },
                gradient: [Colors.purple.shade400, Colors.purple.shade600],
                shadowColor: Colors.purple.withValues(alpha: 0.3),
                icon: '🔥',
                title: 'Advanced Hero Animation',
                subtitle: 'Multiple elements with staggered animations',
              ),

              Spacer(),

              // Footer
              Text(
                'Tap a card to explore different Hero animation techniques',
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCard({
    required Animation<double> animation,
    required VoidCallback onTap,
    required List<Color> gradient,
    required Color shadowColor,
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - animation.value.clamp(0.0, 1.0))),
          child: Transform.scale(
            scale: animation.value.clamp(0.0, 1.0),
            child: Opacity(
              opacity: animation.value.clamp(0.0, 1.0),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: shadowColor, blurRadius: 20, offset: Offset(0, 10))],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(icon, style: TextStyle(fontSize: 32)),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14)),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                              ],
                            ),
                          ],
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
