import 'package:material_ui/material_ui.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class NeedsHelpScreen extends StatelessWidget {
  const NeedsHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.pagePadding),
          child: Text('Needs help', style: AppTextStyles.title),
        ),
      ),
    );
  }
}
