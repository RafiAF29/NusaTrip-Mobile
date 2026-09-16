import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import 'login_page.dart';
import 'ticket_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Profil Saya'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppTheme.darkBrown),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // User Avatar & Primary Info
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            size: 54,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppTheme.darkBrown,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Aisyah Rahma',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'aisyah.traveler@nusatrip.id',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Travel Stats Summary Cards
              Row(
                children: [
                  _buildStatCard('1', 'Tiket Aktif', Icons.confirmation_number_outlined),
                  const SizedBox(width: 12),
                  _buildStatCard('6', 'Tersimpan', Icons.bookmark_border_rounded),
                  const SizedBox(width: 12),
                  _buildStatCard('4', 'Ulasan', Icons.star_border_rounded),
                ],
              ),

              const SizedBox(height: 28),

              // Account Options Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.border),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.darkBrown.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.confirmation_number_outlined,
                      title: 'Tiket Saya',
                      subtitle: 'Lihat tiket perjalanan aktif dan riwayat',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TicketPage()),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16, color: AppTheme.border),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.bookmark_border_rounded,
                      title: 'Destinasi Disimpan',
                      subtitle: 'Daftar tempat impian favoritmu',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16, color: AppTheme.border),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.history_rounded,
                      title: 'Riwayat Perjalanan',
                      subtitle: 'Daftar trip yang telah selesai',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 56, endIndent: 16, color: AppTheme.border),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.help_outline_rounded,
                      title: 'Pusat Bantuan',
                      subtitle: 'FAQ dan layanan pelanggan NusaTrip',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded, color: AppTheme.primary),
                  label: const Text(
                    'Keluar Akun',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 3),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primary, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBrown,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppTheme.darkBrown,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 11,
          color: AppTheme.textMuted,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.textMuted, size: 20),
    );
  }
}
