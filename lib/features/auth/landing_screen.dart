import 'package:material_ui/material_ui.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Image.asset(
                          'assets/images/catlas_icon.png',
                          width: 96,
                          height: 96,
                        ),
                        const SizedBox(height: AppSpacing.large),
                        const Text('Catlas', style: AppTextStyles.title),
                        const SizedBox(height: AppSpacing.small),
                        const Text(
                          'Campus cat care, together.',
                          style: AppTextStyles.subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.medium),
              // Action
              PrimaryButton(
                label: 'Get started',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
