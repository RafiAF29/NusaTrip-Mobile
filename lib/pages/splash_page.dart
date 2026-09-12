import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/safe_image.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBrown,
      body: Stack(
        children: [
          // Background Hero Visual
          Positioned.fill(
            child: Opacity(
              opacity: 0.35,
              child: const SafeImageAsset(
                assetPath: 'lib/assets/images/destinations/borobudur.jpg',
                fallbackIcon: Icons.explore_rounded,
                fallbackText: 'NusaTrip',
              ),
            ),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    AppTheme.darkBrown.withValues(alpha: 0.85),
                    AppTheme.darkBrown,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Content Area
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo Area
                  Container(
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const SafeImageAsset(
                      assetPath: 'lib/assets/images/logo/nusatrip_logo.png',
                      fallbackIcon: Icons.flight_takeoff_rounded,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Main Heading
                  const Text(
                    'Explore\nTravel\nInspire',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // App Title & Tagline
                  const Text(
                    'NusaTrip',
                    style: TextStyle(
                      color: AppTheme.primaryLight,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Jelajahi Nusantara, Ciptakan Cerita',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // CTA Button -> LoginPage
                  CustomButton(
                    text: 'Get Started',
                    backgroundColor: Colors.white,
                    textColor: AppTheme.darkBrown,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
