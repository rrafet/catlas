import 'package:material_ui/material_ui.dart';

import 'features/auth/landing_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CatlasApp());
}

class CatlasApp extends StatelessWidget {
  const CatlasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catlas',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const LandingScreen(),
    );
  }
}
