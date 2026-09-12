import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'safe_image.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String iconFileName;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.iconFileName,
    this.isSelected = false,
    required this.onTap,
  });

  IconData _getCategoryIcon(String title) {
    switch (title.toLowerCase()) {
      case 'alam':
        return Icons.landscape_rounded;
      case 'budaya':
        return Icons.theater_comedy_rounded;
      case 'sejarah':
        return Icons.account_balance_rounded;
      case 'religi':
        return Icons.temple_buddhist_rounded;
      default:
        return Icons.explore_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSelected ? AppTheme.primary : Colors.white;
    final Color textColor = isSelected ? Colors.white : AppTheme.darkBrown;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.border,
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeImageAsset(
              assetPath: 'lib/assets/images/icons/$iconFileName',
              width: 20,
              height: 20,
              fallbackIcon: _getCategoryIcon(title),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
