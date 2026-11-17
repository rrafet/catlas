import 'package:material_ui/material_ui.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class StationsScreen extends StatelessWidget {
  const StationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.pagePadding),
          child: Text('Stations', style: AppTextStyles.title),
        ),
      ),
    );
  }
}
