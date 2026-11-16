import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/placeholder_data.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../home/home_screen.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final _codeController = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  bool get _codeMatches => _codeController.text == joinCode;

  void _join() {
    if (!_codeMatches) {
      setState(() => _showError = true);
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      const Text(
                        'Join your organization',
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: AppSpacing.medium),
                      const Text(
                        'Your campus coordinator can give you a 6-letter '
                        "code. Type it in and you'll see your campus cats, "
                        'feeding stations and reports.',
                        style: AppTextStyles.subtitle,
                      ),
                      const SizedBox(height: AppSpacing.large),
                      // Code field
                      const Text('JOIN CODE', style: AppTextStyles.label),
                      const SizedBox(height: AppSpacing.small),
                      TextField(
                        controller: _codeController,
                        style: AppTextStyles.joinCode,
                        textCapitalization: TextCapitalization.characters,
                        autocorrect: false,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) => newValue.copyWith(
                              text: newValue.text.toUpperCase(),
                            ),
                          ),
                        ],
                        onChanged: (_) => setState(() => _showError = false),
                        onSubmitted: (_) => _join(),
                        decoration: InputDecoration(
                          helperText: _codeMatches ? orgName : null,
                          errorText: _showError
                              ? "This code doesn't match any organization."
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.medium),
              // Action
              PrimaryButton(label: 'Join', onPressed: _join),
              const SizedBox(height: AppSpacing.medium),
              // Footer
              const Text(
                'No code? Ask a volunteer coordinator or an admin.',
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
