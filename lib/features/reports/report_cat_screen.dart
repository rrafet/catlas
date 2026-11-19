import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../data/placeholder_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/cat_photo.dart';
import '../../widgets/primary_button.dart';
import '../map/pick_location_screen.dart';

class ReportCatScreen extends StatefulWidget {
  const ReportCatScreen({super.key, this.initialCat});

  final Cat? initialCat;

  @override
  State<ReportCatScreen> createState() => _ReportCatScreenState();
}

class _ReportCatScreenState extends State<ReportCatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  bool _hasPhoto = false;
  Cat? _cat;
  String? _location;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _cat = widget.initialCat;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _chooseCat() async {
    final cat = await showModalBottomSheet<Cat>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final cat in placeholderCats)
              ListTile(
                leading: CatPhoto(photo: cat.photo, size: 40),
                title: Text(cat.name, style: AppTextStyles.itemTitle),
                subtitle: Text(cat.zone, style: AppTextStyles.itemSubtitle),
                onTap: () => Navigator.pop(context, cat),
              ),
          ],
        ),
      ),
    );
    if (cat != null) {
      setState(() => _cat = cat);
    }
  }

  Future<void> _chooseLocation() async {
    final location = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const PickLocationScreen()),
    );
    if (location != null) {
      setState(() => _location = location);
    }
  }

  void _send() {
    setState(() => _submitted = true);
    final descriptionValid = _formKey.currentState!.validate();
    if (descriptionValid && _hasPhoto && _location != null) {
      _showSentDialog();
    }
  }

  void _showSentDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Report sent.', style: AppTextStyles.heading),
        content: const Text(
          'It now appears in Needs Help.',
          style: AppTextStyles.itemSubtitle,
        ),
        actions: [
          PrimaryButton(
            label: 'Done',
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.pagePadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      const Text('Report a cat', style: AppTextStyles.title),
                      const SizedBox(height: AppSpacing.large),
                      // Photo
                      _PhotoBox(
                        hasPhoto: _hasPhoto,
                        showError: _submitted && !_hasPhoto,
                        onAdd: () => setState(() => _hasPhoto = true),
                        onRemove: () => setState(() => _hasPhoto = false),
                      ),
                      const SizedBox(height: AppSpacing.large),
                      // Cat
                      _ChoiceRow(
                        label: 'CAT  (optional)',
                        value: _cat?.name,
                        emptyText: 'Not linked to a cat',
                        onPressed: _chooseCat,
                      ),
                      const SizedBox(height: AppSpacing.large),
                      // Location
                      _ChoiceRow(
                        label: 'LOCATION',
                        value: _location,
                        emptyText: 'Not set',
                        errorText: _submitted && _location == null
                            ? 'Add where you saw the cat.'
                            : null,
                        onPressed: _chooseLocation,
                      ),
                      const SizedBox(height: AppSpacing.large),
                      // Description
                      AppTextField(
                        label: "What's wrong?",
                        controller: _descriptionController,
                        maxLines: 4,
                        validator: (value) => (value ?? '').trim().length < 10
                            ? 'Tell us a little about what you saw.'
                            : null,
                      ),
                      const SizedBox(height: AppSpacing.large),
                    ],
                  ),
                ),
              ),
              // Action
              Padding(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                child: PrimaryButton(label: 'Send report', onPressed: _send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoBox extends StatelessWidget {
  const _PhotoBox({
    required this.hasPhoto,
    required this.showError,
    required this.onAdd,
    required this.onRemove,
  });

  final bool hasPhoto;
  final bool showError;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    if (hasPhoto) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                'assets/images/cats/SU-002.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          TextButton(onPressed: onRemove, child: const Text('Replace photo')),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onAdd,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            decoration: BoxDecoration(
              border: Border.all(
                color: showError ? AppColors.error : AppColors.divider,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.photo_camera_outlined),
                SizedBox(height: AppSpacing.medium),
                Text('Add a photo', style: AppTextStyles.itemTitle),
                SizedBox(height: AppSpacing.tiny),
                Text(
                  'Take one now or choose from your gallery',
                  style: AppTextStyles.itemSubtitle,
                ),
              ],
            ),
          ),
        ),
        if (showError) ...[
          const SizedBox(height: AppSpacing.small),
          const Text(
            'A photo helps volunteers find the right cat.',
            style: TextStyle(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
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
