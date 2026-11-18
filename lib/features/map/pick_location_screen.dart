import 'package:material_ui/material_ui.dart';

import '../../data/placeholder_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/campus_map.dart';
import '../../widgets/primary_button.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  static const double _pinSize = 40;

  Offset _pin = campusSpots['Campus Centre']!;

  String get _nearestSpot {
    String nearest = campusSpots.keys.first;
    for (final entry in campusSpots.entries) {
      if ((entry.value - _pin).distance <
          (campusSpots[nearest]! - _pin).distance) {
        nearest = entry.key;
      }
    }
    return nearest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick location')),
      body: SafeArea(
        child: Column(
          children: [
            // Map
            Expanded(
              child: CampusMap(
                onTap: (position) => setState(() => _pin = position),
                markers: [
                  MapMarker(
                    position: _pin,
                    child: Transform.translate(
                      offset: const Offset(0, -_pinSize / 2),
                      child: const Icon(
                        Icons.location_on,
                        size: _pinSize,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Panel
            Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_nearestSpot, style: AppTextStyles.heading),
                  const SizedBox(height: AppSpacing.tiny),
                  const Text(
                    'Tap the map to move the pin.',
                    style: AppTextStyles.itemSubtitle,
                  ),
                  const SizedBox(height: AppSpacing.large),
                  PrimaryButton(
                    label: 'Confirm location',
                    onPressed: () => Navigator.pop(context, _nearestSpot),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
