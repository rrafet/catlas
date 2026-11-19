import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';

// Shows "22 h" style timers. After 16 hours the number turns amber.
class HoursText extends StatelessWidget {
  const HoursText({super.key, required this.hours, this.fontSize = 24});

  final int hours;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final color = hours >= 16 ? AppColors.accent : AppColors.textPrimary;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: hours < 1 ? '<1' : '$hours',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: ' h',
            style: TextStyle(fontSize: fontSize / 2),
          ),
        ],
      ),
      style: TextStyle(color: color),
    );
  }
}
