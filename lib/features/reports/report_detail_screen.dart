import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../data/placeholder_data.dart';
import '../../data/report.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cat_photo.dart';
import '../../widgets/primary_button.dart';
import '../cats/cat_profile_screen.dart';

class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key, required this.report});

  final Report report;

  // The listed cat this report is about, or null for an unlisted cat.
  Cat? get _linkedCat {
    for (final cat in placeholderCats) {
      if (cat.name == report.catName) return cat;
    }
    return null;
  }

  Future<void> _confirmResolve(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Mark this report as resolved?',
          style: AppTextStyles.itemTitle.copyWith(fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'It will be removed from Needs Help.',
          style: AppTextStyles.itemSubtitle,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.medium,
                vertical: AppSpacing.small,
              ),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Resolve'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    // Tell the Needs Help list which report to remove.
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final cat = _linkedCat;
    final photoSize =
        MediaQuery.sizeOf(context).width - AppSpacing.pagePadding * 2;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'REPORT · ${report.place.toUpperCase()}',
                      style: AppTextStyles.label,
                    ),
                    const SizedBox(height: AppSpacing.small),
                    Text(report.summary, style: AppTextStyles.heading),
                    const SizedBox(height: AppSpacing.medium),
                    CatPhoto(photo: report.photo, size: photoSize),
                    const SizedBox(height: AppSpacing.medium),
                    // Details
                    _DetailRow(
                      label: 'CAT',
                      value: report.catName ?? 'Unlisted cat',
                      onTap: cat == null
                          ? null
                          : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CatProfileScreen(cat: cat),
                              ),
                            ),
                    ),
                    _DetailRow(label: 'PLACE', value: report.place),
                    _DetailRow(
                      label: 'REPORTED',
                      value: timeAgo(report.reportedAt),
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    const Text('DESCRIPTION', style: AppTextStyles.label),
                    const SizedBox(height: AppSpacing.small),
                    Text(report.description, style: AppTextStyles.body),
                    const SizedBox(height: AppSpacing.medium),
                  ],
                ),
              ),
            ),
            // Action
            Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: PrimaryButton(
                label: 'Mark as resolved',
                onPressed: () => _confirmResolve(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.onTap});

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
            child: Row(
              children: [
                Text(label, style: AppTextStyles.label),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: Text(
                    value,
                    style: AppTextStyles.body,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onTap != null) ...[
                  const SizedBox(width: AppSpacing.tiny),
                  const Icon(Icons.chevron_right, size: 20),
                ],
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
