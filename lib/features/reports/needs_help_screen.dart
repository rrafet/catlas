import 'package:material_ui/material_ui.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import 'report_cat_screen.dart';

class NeedsHelpScreen extends StatelessWidget {
  const NeedsHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const Text('Needs help', style: AppTextStyles.title),
              const SizedBox(height: AppSpacing.large),
              // Action
              PrimaryButton(
                label: 'Report a cat',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const ReportCatScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
