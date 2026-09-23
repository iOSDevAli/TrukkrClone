import 'package:flutter/material.dart';
//import '../widgets/splash_illustration.dart';
import '../widgets/splash_road_scene.dart';
import '../widgets/trukkr_logo_mark.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 6200))
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3B82F6), Color(0xFFEAF2FE), Color(0xFFD9E7F5)],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TrukkrLogoMark(size: 56),
                  const SizedBox(width: 12),
                  const Text('Trukkr', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Color(0xFF16233F))),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Smarter Logistics.\nStronger Tomorrow.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Color(0xFF6B8CB3), height: 1.4, fontWeight: FontWeight.w500),
              ),
              const Spacer(flex: 3),
              const SplashRoadScene(height: 240),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _controller.value,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFCBDDF2),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF2563EB)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Loading...', style: TextStyle(color: Color(0xFF6B8CB3), fontSize: 13)),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
