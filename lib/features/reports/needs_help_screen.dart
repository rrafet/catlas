import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../data/placeholder_data.dart';
import '../../data/report.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cat_photo.dart';
import '../../widgets/primary_button.dart';
import 'report_cat_screen.dart';
import 'report_detail_screen.dart';

class NeedsHelpScreen extends StatefulWidget {
  const NeedsHelpScreen({super.key});

  @override
  State<NeedsHelpScreen> createState() => _NeedsHelpScreenState();
}

class _NeedsHelpScreenState extends State<NeedsHelpScreen> {
  Future<void> _openReport(Report report) async {
    final resolved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => ReportDetailScreen(report: report),
      ),
    );
    if (resolved != true || !mounted) return;

    // Placeholder until reports are stored in Firestore (Step 3).
    setState(() => placeholderReports.remove(report));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Report resolved')));
  }

  Future<void> _reportCat() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const ReportCatScreen(),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Newest reports first.
    final reports = [...placeholderReports]
      ..sort((a, b) => b.reportedAt.compareTo(a.reportedAt));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                children: [
                  // Header
                  const Text('Needs help', style: AppTextStyles.title),
                  const SizedBox(height: AppSpacing.tiny),
                  Text(
                    reports.length == 1
                        ? '1 open report'
                        : '${reports.length} open reports',
                    style: AppTextStyles.itemSubtitle,
                  ),
                  const SizedBox(height: AppSpacing.large),
                  const Divider(),
                  // Reports
                  if (reports.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.large),
                      child: Center(
                        child: Text(
                          'No cats need help right now',
                          style: AppTextStyles.itemSubtitle,
                        ),
                      ),
                    ),
                  for (final report in reports)
                    _ReportCard(
                      report: report,
                      onTap: () => _openReport(report),
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
              child: PrimaryButton(label: 'Report a cat', onPressed: _reportCat),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.report, required this.onTap});

  final Report report;
  final VoidCallback onTap;

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
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor: AppColors.needsHelp,
                        ),
                        const SizedBox(width: AppSpacing.small),
                        Expanded(
                          child: Text(
                            report.summary,
                            style: AppTextStyles.itemTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.tiny),
                    Text(
                      '${report.catName ?? 'Unlisted cat'} · ${report.place}',
                      style: AppTextStyles.itemSubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      timeAgo(report.reportedAt),
                      style: AppTextStyles.itemSubtitle,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.medium),
              CatPhoto(photo: report.photo, size: AppSpacing.thumbnail),
            ],
          ),
        ),
      ),
    );
  }
}
