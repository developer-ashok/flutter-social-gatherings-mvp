import 'package:flutter/material.dart';
import 'dart:math' as math;

class CreativeBackground extends StatefulWidget {
  final Widget child;
  final bool showFloatingElements;

  const CreativeBackground({
    super.key,
    required this.child,
    this.showFloatingElements = true,
  });

  @override
  State<CreativeBackground> createState() => _CreativeBackgroundState();
}

class _CreativeBackgroundState extends State<CreativeBackground>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_floatingController);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(_pulseController);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFF8F9FA),
                const Color(0xFFE8F4F8),
                const Color(0xFFF0F8FF),
              ],
            ),
          ),
        ),
        
        // Animated floating elements
        if (widget.showFloatingElements) ...[
          // Floating circles
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Positioned(
                top: 100 + 50 * math.sin(_floatingAnimation.value),
                left: 50 + 30 * math.cos(_floatingAnimation.value * 0.5),
                child: _buildFloatingCircle(
                  size: 60,
                  color: const Color(0xFF2C3E50).withOpacity(0.1),
                ),
              );
            },
          ),
          
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Positioned(
                top: 200 + 40 * math.sin(_floatingAnimation.value * 1.5),
                right: 80 + 40 * math.cos(_floatingAnimation.value * 0.8),
                child: _buildFloatingCircle(
                  size: 40,
                  color: const Color(0xFF27AE60).withOpacity(0.1),
                ),
              );
            },
          ),
          
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: 150 + 60 * math.sin(_floatingAnimation.value * 0.7),
                left: 100 + 50 * math.cos(_floatingAnimation.value * 1.2),
                child: _buildFloatingCircle(
                  size: 80,
                  color: const Color(0xFFF39C12).withOpacity(0.1),
                ),
              );
            },
          ),
          
          // Pulsing elements
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Positioned(
                top: 300,
                right: 30,
                child: Transform.scale(
                  scale: _pulseAnimation.value,
                  child: _buildFloatingCircle(
                    size: 30,
                    color: const Color(0xFF95A5A6).withOpacity(0.15),
                  ),
                ),
              );
            },
          ),
          
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: 300,
                left: 30,
                child: Transform.scale(
                  scale: _pulseAnimation.value * 0.8,
                  child: _buildFloatingCircle(
                    size: 50,
                    color: const Color(0xFFE74C3C).withOpacity(0.1),
                  ),
                ),
              );
            },
          ),
        ],
        
        // Main content
        widget.child,
      ],
    );
  }

  Widget _buildFloatingCircle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}

class ZenPatternBackground extends StatelessWidget {
  final Widget child;
  final double opacity;

  const ZenPatternBackground({
    super.key,
    required this.child,
    this.opacity = 0.05,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Zen pattern overlay
        CustomPaint(
          painter: ZenPatternPainter(opacity: opacity),
          size: Size.infinite,
        ),
        child,
      ],
    );
  }
}

class ZenPatternPainter extends CustomPainter {
  final double opacity;

  ZenPatternPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2C3E50).withOpacity(opacity)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw zen circles
    for (int i = 0; i < 5; i++) {
      final center = Offset(
        size.width * (0.2 + i * 0.15),
        size.height * (0.1 + i * 0.2),
      );
      final radius = 30.0 + i * 10.0;
      
      canvas.drawCircle(center, radius, paint);
    }

    // Draw zen lines
    for (int i = 0; i < 3; i++) {
      final start = Offset(
        size.width * 0.1,
        size.height * (0.3 + i * 0.2),
      );
      final end = Offset(
        size.width * 0.9,
        size.height * (0.3 + i * 0.2),
      );
      
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AnimatedGradientCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const AnimatedGradientCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  State<AnimatedGradientCard> createState() => _AnimatedGradientCardState();
}

class _AnimatedGradientCardState extends State<AnimatedGradientCard>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _gradientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _gradientAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_gradientController);
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: _gradientAnimation,
        builder: (context, child) {
          return Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.7),
                  Colors.white.withOpacity(0.8),
                ],
                stops: [
                  _gradientAnimation.value,
                  (_gradientAnimation.value + 0.3) % 1.0,
                  (_gradientAnimation.value + 0.6) % 1.0,
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
} 