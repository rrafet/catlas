import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../data/placeholder_data.dart';
import '../../data/station.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/campus_map.dart';
import '../../widgets/cat_photo.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  void _showPreview(BuildContext context, Widget content) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: content,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCat(BuildContext context, Cat cat) {
    _showPreview(
      context,
      Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cat.name, style: AppTextStyles.heading),
                const SizedBox(height: AppSpacing.tiny),
                Text(
                  '${cat.zone} · Seen ${cat.lastSeen}',
                  style: AppTextStyles.itemSubtitle,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.medium),
          CatPhoto(photo: cat.photo, size: AppSpacing.thumbnail),
        ],
      ),
    );
  }

  void _showStation(BuildContext context, Station station) {
    _showPreview(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(station.name, style: AppTextStyles.heading),
          const SizedBox(height: AppSpacing.small),
          Text('Food: ${station.lastFood}', style: AppTextStyles.body),
          const SizedBox(height: AppSpacing.tiny),
          Text('Water: ${station.lastWater}', style: AppTextStyles.body),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(AppSpacing.pagePadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Map', style: AppTextStyles.title),
              ),
            ),
            // Map
            Expanded(
              child: CampusMap(
                markers: [
                  for (final station in placeholderStations)
                    MapMarker(
                      position: station.mapPosition,
                      child: GestureDetector(
                        onTap: () => _showStation(context, station),
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.accent,
                          child: Icon(
                            Icons.restaurant,
                            size: 16,
                            color: AppColors.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  for (final cat in placeholderCats)
                    MapMarker(
                      position: cat.mapPosition,
                      child: GestureDetector(
                        onTap: () => _showCat(context, cat),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.textPrimary,
                          child: ClipOval(
                            child: CatPhoto(photo: cat.photo, size: 32),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Footer
            const Padding(
              padding: EdgeInsets.all(AppSpacing.medium),
              child: Text(
                'Markers show reported sightings, not live tracking.',
                style: AppTextStyles.itemSubtitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
