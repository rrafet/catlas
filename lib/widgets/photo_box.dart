import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'cat_photo.dart';

class PhotoBox extends StatelessWidget {
  const PhotoBox({
    super.key,
    required this.photo,
    required this.showError,
    required this.onAdd,
    required this.onRemove,
  });

  final String? photo;
  final bool showError;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    if (photo != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: CatPhoto(photo: photo, size: AppSpacing.photoTile),
          ),
          TextButton(onPressed: onRemove, child: const Text('Replace photo')),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onAdd,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            decoration: BoxDecoration(
              border: Border.all(
                color: showError ? AppColors.error : AppColors.divider,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.photo_camera_outlined),
                SizedBox(height: AppSpacing.medium),
                Text('Add a photo', style: AppTextStyles.itemTitle),
                SizedBox(height: AppSpacing.tiny),
                Text(
                  'Take one now or choose from your gallery',
                  style: AppTextStyles.itemSubtitle,
                ),
              ],
            ),
          ),
        ),
        if (showError) ...[
          const SizedBox(height: AppSpacing.small),
          const Text(
            'A photo helps volunteers find the right cat.',
            style: TextStyle(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
