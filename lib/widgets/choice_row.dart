import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class ChoiceRow extends StatelessWidget {
  const ChoiceRow({
    super.key,
    required this.label,
    required this.value,
    required this.emptyText,
    required this.onPressed,
    this.errorText,
  });

  final String label;
  final String? value;
  final String emptyText;
  final VoidCallback onPressed;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: errorText == null ? AppColors.divider : AppColors.error,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value ?? emptyText,
                  style: value == null
                      ? AppTextStyles.itemSubtitle
                      : AppTextStyles.body,
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  value == null ? 'Choose' : 'Change',
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.small),
          Text(errorText!, style: const TextStyle(color: AppColors.error)),
        ],
      ],
    );
  }
}
