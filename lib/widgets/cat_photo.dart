import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class CatPhoto extends StatelessWidget {
  const CatPhoto({super.key, required this.photo, required this.size});

  final String photo;
  final double size;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: size,
      height: size,
      color: AppColors.divider,
      child: Icon(Icons.pets, size: size / 2, color: AppColors.textSecondary),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      child: photo.startsWith('http')
          ? Image.network(
              photo,
              width: size,
              height: size,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : fallback,
              errorBuilder: (context, error, stackTrace) => fallback,
            )
          : Image.asset(photo, width: size, height: size, fit: BoxFit.cover),
    );
  }
}
