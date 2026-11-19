import 'package:material_ui/material_ui.dart';

import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.label, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label.toUpperCase(), style: AppTextStyles.label),
            ),
            ?trailing,
          ],
        ),
        const SizedBox(height: AppSpacing.small),
        const Divider(),
      ],
    );
  }
}
