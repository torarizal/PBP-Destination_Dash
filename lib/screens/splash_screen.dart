import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import './login_page.dart';

// Fungsi utama untuk menjalankan aplikasi
void main() {
  runApp(const MyApp());
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destination Dash',
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

// Widget SplashScreen dengan state
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Controller untuk berbagai animasi
  late final AnimationController _controller;
  late final AnimationController _compassController;
  late final AnimationController _loadingController;

  // Animasi untuk fade, scale, dan rotasi kompas
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _compassAnimation;
  late final Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller utama untuk fade-in dan zoom
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Inisialisasi controller untuk animasi kompas
    _compassController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    // Inisialisasi controller untuk loading bar
    _loadingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Mendefinisikan kurva animasi
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Mendefinisikan animasi sekuensial untuk kompas agar bergerak natural
    _compassAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -0.26),
        weight: 25,
      ), // -15 deg
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.26, end: 0.35),
        weight: 25,
      ), // 20 deg
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.35, end: -0.087),
        weight: 25,
      ), // -5 deg
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.087, end: 0),
        weight: 25,
      ), // 0 deg
    ]).animate(_compassController);

    // Mendefinisikan animasi untuk progress loading bar
    _loadingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeOut),
    );

    // Memulai animasi
    _controller.forward();
    _loadingController.forward();

    // Navigasi ke halaman login setelah splash screen selesai
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    // Membersihkan controller untuk mencegah memory leak
    _controller.dispose();
    _compassController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradien latar belakang seperti di versi web
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A), // slate-900
              Color(0xFF1E3A8A), // blue-900
              Color(0xFF0F172A), // slate-900
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Konten utama di tengah
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Kompas yang beranimasi
                      RotationTransition(
                        turns: _compassAnimation,
                        child: const CompassLogo(size: 96),
                      ),
                      const SizedBox(height: 24),
                      // Nama Aplikasi
                      const Text(
                        'Destination Dash',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Tagline
                      Text(
                        'Menyiapkan petualangan Anda...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[200]?.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Loading bar di bagian bawah
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 40.0,
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 300),
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: AnimatedBuilder(
                    animation: _loadingAnimation,
                    builder: (context, child) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _loadingAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kustom untuk menggambar logo kompas
class CompassLogo extends StatelessWidget {
  final double size;
  const CompassLogo({Key? key, this.size = 96.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _CompassPainter());
  }
}

// CustomPainter untuk menggambar kompas
class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Lingkaran luar
    final circlePaint = Paint()
      ..color = Colors.blue[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius, circlePaint);

    // Garis-garis penunjuk arah (minor)
    final linePaint = Paint()
      ..color = Colors.blue[300]!.withOpacity(0.4)
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 4; i++) {
      final angle = (i * math.pi / 2) + (math.pi / 4);
      final start =
          center +
          Offset(
            math.cos(angle) * radius * 0.7,
            math.sin(angle) * radius * 0.7,
          );
      final end =
          center + Offset(math.cos(angle) * radius, math.sin(angle) * radius);
      canvas.drawLine(start, end, linePaint);
    }

    // Jarum utama (bagian bawah)
    final needleBasePaint = Paint()
      ..color = Colors.blue[300]!.withOpacity(0.6)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center + Offset(0, radius),
      center + Offset(0, radius * 0.1),
      needleBasePaint,
    );

    // Jarum utama (bagian atas yang bergerak)
    // Di-handle oleh RotationTransition, di sini kita gambar versi statisnya
    final needlePaint = Paint()
      ..color = Colors.blue[300]!
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center + Offset(0, -radius),
      center + Offset(0, -radius * 0.08),
      needlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
