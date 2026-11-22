import 'package:material_ui/material_ui.dart';

import '../../data/placeholder_data.dart';
import '../../data/session.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../auth/landing_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logOut(BuildContext context) {
    signedInEmail = '';
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pagePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      CircleAvatar(
                        radius: AppSpacing.thumbnail / 2,
                        backgroundColor: AppColors.divider,
                        foregroundColor: AppColors.textPrimary,
                        child: displayName.isEmpty
                            ? const Icon(Icons.person_outline)
                            : Text(
                                displayName[0],
                                style: AppTextStyles.heading,
                              ),
                      ),
                      const SizedBox(height: AppSpacing.large),
                      Text(
                        displayName.isEmpty ? 'Member' : displayName,
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: AppSpacing.tiny),
                      Text(signedInEmail, style: AppTextStyles.itemSubtitle),
                      const SizedBox(height: AppSpacing.large),
                      // Details
                      const Divider(),
                      const _InfoRow(label: 'Organization', value: orgName),
                      _InfoRow(label: 'Role', value: role),
                      const _InfoRow(label: 'Join code', value: joinCode),
                    ],
                  ),
                ),
              ),
              // Action
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.medium,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () => _logOut(context),
                  child: const Text(
                    'Log out',
                    style: TextStyle(decoration: TextDecoration.underline),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
          child: Row(
            children: [
              Text(label, style: AppTextStyles.itemSubtitle),
              const SizedBox(width: AppSpacing.medium),
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.itemTitle,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
