import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/auth_field.dart';
import '../widgets/google_g_icon.dart';
import '../widgets/splash_road_scene.dart';
import '../widgets/trukkr_logo_mark.dart';
import 'main_shell.dart';

/// The Login screen shown right after the splash screen. There's no
/// real backend yet, so [_signIn] accepts any non-empty email/password
/// (matching "give some hardcoded email and password" in the request)
/// and moves straight to the Dashboard.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToDashboard() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainShell()));
  }

  void _signIn() {
    if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter any email and password to continue')),
      );
      return;
    }
    // No real auth yet — any non-empty credentials are accepted.
    _goToDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2FE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: _CurvedBottomClipper(),
              child: Container(
                width: double.infinity,
                height: 320,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF3B82F6), Color(0xFFEAF2FE), Color(0xFFD9E7F5)],
                    stops: [0.0, 0.6, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    const Positioned(left: 0, right: 0, bottom: 0, child: SplashRoadScene(height: 190)),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TrukkrLogoMark(size: 40),
                              const SizedBox(width: 10),
                              const Text('Trukkr', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.headerNavyDark)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Smarter Logistics.\nStronger Tomorrow.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF6B8CB3), height: 1.35, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 8))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Welcome Back!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.headerNavyDark)),
                    const SizedBox(height: 4),
                    const Text('Sign in to your Trukkr account', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                    const SizedBox(height: 22),
                    AuthField(
                      icon: Icons.person,
                      label: 'Email',
                      hint: 'user@example.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),
                    AuthField(
                      icon: Icons.vpn_key_rounded,
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      trailing: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textSecondary, size: 20),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF3B82F6)]),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: _goToDashboard,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoogleGIcon(size: 20),
                            SizedBox(width: 10),
                            Text('Continue with Google', style: TextStyle(color: AppColors.headerNavyDark, fontSize: 15, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Text('Your data is safe with us', style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.9), fontSize: 12.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 36);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 36);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
