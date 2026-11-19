import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cat_photo.dart';
import '../reports/report_cat_screen.dart';

class CatProfileScreen extends StatelessWidget {
  const CatProfileScreen({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
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
                    CatPhoto(photo: cat.photo, size: photoSize),
                    const SizedBox(height: AppSpacing.large),
                    Text(cat.name, style: AppTextStyles.title),
                    const SizedBox(height: AppSpacing.tiny),
                    Text(cat.zone, style: AppTextStyles.itemSubtitle),
                    const SizedBox(height: AppSpacing.medium),
                    Text(
                      'Last seen ${timeAgo(cat.lastSeen)} near ${cat.lastSeenPlace}.',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
            ),
            // Actions
            Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ReportCatScreen(initialCat: cat),
                    ),
                  ),
                  child: const Text(
                    'Report a problem',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
