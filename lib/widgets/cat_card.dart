import 'package:material_ui/material_ui.dart';

import '../data/cat.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'cat_photo.dart';

class CatCard extends StatelessWidget {
  const CatCard({super.key, required this.cat, this.onTap});

  final Cat cat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cat.name,
                      style: AppTextStyles.itemTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.tiny),
                    Text(
                      '${cat.zone} · Seen ${timeAgo(cat.lastSeen)}',
                      style: AppTextStyles.itemSubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.medium),
              CatPhoto(photo: cat.photo, size: AppSpacing.thumbnail),
            ],
          ),
        ),
      ),
    );
  }
}
