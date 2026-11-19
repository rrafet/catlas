import 'package:material_ui/material_ui.dart';

import '../../data/placeholder_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/hours_text.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({super.key});

  @override
  State<StationsScreen> createState() => _StationsScreenState();
}

class _StationsScreenState extends State<StationsScreen> {
  static const double _timerWidth = 64;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          children: [
            // Header
            const Text('Stations', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.medium),
            const Text(
              "How long it's been since someone logged a refill. After 16 "
              "hours the number turns yellow. It doesn't mean the bowl is "
              "empty, so take a quick look if you're walking by.",
              style: AppTextStyles.itemSubtitle,
            ),
            const SizedBox(height: AppSpacing.large),
            // Column titles
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${placeholderStations.length} STATIONS',
                    style: AppTextStyles.label,
                  ),
                ),
                const SizedBox(
                  width: _timerWidth,
                  child: Text('Food', style: AppTextStyles.itemSubtitle),
                ),
                const SizedBox(
                  width: _timerWidth,
                  child: Text('Water', style: AppTextStyles.itemSubtitle),
                ),
              ],
            ),
            const Divider(),
            // List
            for (final station in placeholderStations) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(station.name, style: AppTextStyles.itemTitle),
                          Text(station.area, style: AppTextStyles.itemSubtitle),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: _timerWidth,
                      child: HoursText(hours: station.foodHours),
                    ),
                    SizedBox(
                      width: _timerWidth,
                      child: HoursText(hours: station.waterHours),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.divider),
            ],
          ],
        ),
      ),
    );
  }
}
