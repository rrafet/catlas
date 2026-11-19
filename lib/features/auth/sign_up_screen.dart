import 'package:material_ui/material_ui.dart';

import '../../data/session.dart';
import '../../data/validators.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';
import 'join_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _confirmFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    signedInEmail = _emailController.text.trim();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const JoinScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pagePadding,
            0,
            AppSpacing.pagePadding,
            AppSpacing.pagePadding,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text('Create an account', style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.medium),
                const Text(
                  "After this, you'll join your campus with a code.",
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: AppSpacing.large),
                // Fields
                AppTextField(
                  label: 'Name',
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      (value ?? '').trim().isEmpty ? 'Enter your name.' : null,
                ),
                const SizedBox(height: AppSpacing.large),
                AppTextField(
                  label: 'Email',
                  controller: _emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.large),
                AppTextField(
                  label: 'Password',
                  controller: _passwordController,
                  validator: validatePassword,
                  helperText: 'At least 8 characters.',
                  obscureText: true,
                  onChanged: (_) {
                    if (_confirmController.text.isNotEmpty) {
                      _confirmFieldKey.currentState!.validate();
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.large),
                AppTextField(
                  label: 'Confirm password',
                  controller: _confirmController,
                  fieldKey: _confirmFieldKey,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) => value != _passwordController.text
                      ? "Passwords don't match."
                      : null,
                ),
                const SizedBox(height: AppSpacing.large),
                // Action
                PrimaryButton(label: 'Create account', onPressed: _submit),
                const SizedBox(height: AppSpacing.medium),
                // Footer
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: AppTextStyles.itemSubtitle,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
