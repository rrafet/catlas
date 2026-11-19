import 'dart:math';

import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../data/placeholder_data.dart';
import '../../data/report.dart';
import '../../data/session.dart';
import '../../data/station.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cat_photo.dart';
import '../../widgets/hours_text.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_header.dart';
import '../cats/cat_profile_screen.dart';
import '../reports/report_cat_screen.dart';
import '../sightings/new_sighting_screen.dart';
import '../stations/station_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onSeeAllReports});

  final VoidCallback onSeeAllReports;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _open(Widget screen, {bool fullscreenDialog = false}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => screen,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final stations = [...placeholderStations]
      ..sort(
        (a, b) => max(
          b.foodHours,
          b.waterHours,
        ).compareTo(max(a.foodHours, a.waterHours)),
      );
    final cats = [...placeholderCats]
      ..sort((a, b) => b.lastSeen.compareTo(a.lastSeen));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          orgName.toUpperCase(),
                          style: AppTextStyles.label,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.divider,
                        foregroundColor: AppColors.textPrimary,
                        child: displayName.isEmpty
                            ? const Icon(Icons.person_outline, size: 20)
                            : Text(displayName[0]),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  Text(
                    displayName.isEmpty ? 'Hello.' : 'Hello, $displayName.',
                    style: AppTextStyles.title,
                  ),
                  const SizedBox(height: AppSpacing.large),
                  // Needs help
                  SectionHeader(
                    label: 'Needs help',
                    trailing: TextButton(
                      onPressed: widget.onSeeAllReports,
                      child: Text('All ${placeholderReports.length}'),
                    ),
                  ),
                  for (final report in placeholderReports)
                    _ReportRow(report: report),
                  const SizedBox(height: AppSpacing.large),
                  // Check next
                  const SectionHeader(
                    label: 'Check next',
                    trailing: Text(
                      'Since last refill',
                      style: AppTextStyles.itemSubtitle,
                    ),
                  ),
                  for (final station in stations.take(3))
                    _StationRow(
                      station: station,
                      onTap: () => _open(StationDetailScreen(station: station)),
                    ),
                  const SizedBox(height: AppSpacing.large),
                  // Recently seen
                  const SectionHeader(label: 'Recently seen'),
                  const SizedBox(height: AppSpacing.small),
                  SizedBox(
                    height: AppSpacing.photoTile,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: cats.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: AppSpacing.small),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _open(CatProfileScreen(cat: cats[index])),
                        child: CatPhoto(
                          photo: cats[index].photo,
                          size: AppSpacing.photoTile,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Action
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
                vertical: AppSpacing.medium,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Log a sighting',
                      onPressed: () => _open(const NewSightingScreen()),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  TextButton(
                    onPressed: () =>
                        _open(const ReportCatScreen(), fullscreenDialog: true),
                    child: const Text(
                      'Report a cat',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
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

class _ReportRow extends StatelessWidget {
  const _ReportRow({required this.report});

  final Report report;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor: AppColors.needsHelp,
                        ),
                        const SizedBox(width: AppSpacing.small),
                        Expanded(
                          child: Text(
                            report.catName ?? 'Unlisted cat',
                            style: AppTextStyles.itemTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${report.summary} · ${report.place} · '
                      '${timeAgo(report.reportedAt)}',
                      style: AppTextStyles.itemSubtitle,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.medium),
              CatPhoto(photo: report.photo, size: AppSpacing.smallThumbnail),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _StationRow extends StatelessWidget {
  const _StationRow({required this.station, required this.onTap});

  final Station station;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isFood = station.foodHours >= station.waterHours;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(station.name, style: AppTextStyles.itemTitle),
                      Text(
                        isFood ? 'Food' : 'Water',
                        style: AppTextStyles.itemSubtitle,
                      ),
                    ],
                  ),
                ),
                HoursText(
                  hours: isFood ? station.foodHours : station.waterHours,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
