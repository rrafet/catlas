import 'package:material_ui/material_ui.dart';

import '../../data/station.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/hours_text.dart';

const List<String> _refillTypes = ['Food', 'Water', 'Both'];

// Sample history rows until refills are stored.
const List<(String, String)> _history = [
  ('Water · Cansu', 'Today 15:30'),
  ('Food · Ecem', 'Today 07:30'),
  ('Food and water · Hakan', 'Yesterday 19:10'),
];

class StationDetailScreen extends StatefulWidget {
  const StationDetailScreen({super.key, required this.station});

  final Station station;

  @override
  State<StationDetailScreen> createState() => _StationDetailScreenState();
}

class _StationDetailScreenState extends State<StationDetailScreen> {
  String _refillType = 'Food';

  @override
  Widget build(BuildContext context) {
    final station = widget.station;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pagePadding,
          ),
          children: [
            // Header
            Text(
              'FEEDING STATION · ${station.area.toUpperCase()}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: AppSpacing.small),
            Text(station.name, style: AppTextStyles.heading),
            const SizedBox(height: AppSpacing.large),
            // Timers
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _Timer(
                    label: 'FOOD',
                    hours: station.foodHours,
                    by: station.foodBy,
                  ),
                ),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: _Timer(
                    label: 'WATER',
                    hours: station.waterHours,
                    by: station.waterBy,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.medium),
            const Divider(color: AppColors.divider),
            const SizedBox(height: AppSpacing.medium),
            // Refill type
            const Text('LOG A REFILL', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.small),
            Row(
              children: [
                for (final type in _refillTypes)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.large),
                    child: GestureDetector(
                      onTap: () => setState(() => _refillType = type),
                      child: Text(
                        type,
                        style: AppTextStyles.itemTitle.copyWith(
                          fontSize: 20,
                          color: type == _refillType
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          decoration: type == _refillType
                              ? TextDecoration.underline
                              : null,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.small),
            const Text(
              'Once you log it, the timer starts over for everyone.',
              style: AppTextStyles.itemSubtitle,
            ),
            const SizedBox(height: AppSpacing.large),
            // History
            const Text('HISTORY', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.small),
            for (final (action, time) in _history) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
                child: Row(
                  children: [
                    Expanded(child: Text(action, style: AppTextStyles.body)),
                    Text(time, style: AppTextStyles.itemSubtitle),
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

class _Timer extends StatelessWidget {
  const _Timer({required this.label, required this.hours, required this.by});

  final String label;
  final int hours;
  final String by;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        HoursText(hours: hours, fontSize: 48),
        Text(by, style: AppTextStyles.itemSubtitle),
      ],
    );
  }
}
