import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cat_photo.dart';
import '../../widgets/primary_button.dart';
import '../reports/report_cat_screen.dart';
import '../sightings/new_sighting_screen.dart';

class CatProfileScreen extends StatefulWidget {
  const CatProfileScreen({super.key, required this.cat});

  final Cat cat;

  @override
  State<CatProfileScreen> createState() => _CatProfileScreenState();
}

class _CatProfileScreenState extends State<CatProfileScreen> {
  Future<void> _logSighting() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => NewSightingScreen(initialCat: widget.cat),
      ),
    );
    // Show the new last seen time if the sighting updated it.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cat = widget.cat;
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
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'I saw this cat',
                      onPressed: _logSighting,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  TextButton(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
