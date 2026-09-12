import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/safe_image.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Logo & App Name Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const SafeImageAsset(
                        assetPath: 'lib/assets/images/logo/nusatrip_logo.png',
                        fallbackIcon: Icons.travel_explore_rounded,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'NusaTrip',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Temukan Destinasi Impianmu',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Title Section
              const Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Masuk untuk merencanakan petualangan wisatamu di Nusantara.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textMuted,
                ),
              ),
              const SizedBox(height: 28),

              // Form UI (UI Prototype Only)
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'nama@email.com',
                  prefixIcon: Icon(Icons.email_outlined, color: AppTheme.primary),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Kata Sandi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: Icon(Icons.lock_outline_rounded, color: AppTheme.primary),
                  suffixIcon: Icon(Icons.visibility_off_outlined, color: AppTheme.textMuted),
                ),
              ),
              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Lupa Kata Sandi?',
                    style: TextStyle(color: AppTheme.primary, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login Button -> HomePage
              CustomButton(
                text: 'Masuk',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 16),

              // Continue as Guest Button -> HomePage
              CustomButton(
                text: 'Lanjutkan sebagai Tamu',
                isOutlined: true,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 32),

              // Travel Illustration Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.stars_rounded, color: AppTheme.primary, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Jelajahi Wae Rebo, Raja Ampat & Danau Toba bersama NusaTrip.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.darkBrown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
