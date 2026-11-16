import 'package:material_ui/material_ui.dart';

import '../../data/placeholder_data.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orgName.toUpperCase(), style: AppTextStyles.label),
              const SizedBox(height: AppSpacing.small),
              const Text('Home', style: AppTextStyles.title),
            ],
          ),
        ),
      ),
    );
  }
}
