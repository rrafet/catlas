import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../data/placeholder_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/photo_box.dart';
import '../../widgets/primary_button.dart';

class AddEditCatScreen extends StatefulWidget {
  const AddEditCatScreen({super.key, this.cat});

  final Cat? cat;

  @override
  State<AddEditCatScreen> createState() => _AddEditCatScreenState();
}

class _AddEditCatScreenState extends State<AddEditCatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _photo;
  String? _zone;
  String? _colour;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    final cat = widget.cat;
    if (cat != null) {
      _nameController.text = cat.name;
      _descriptionController.text = cat.description;
      _photo = cat.photo;
      _zone = cat.zone;
      _colour = cat.colour.isEmpty ? null : cat.colour;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() => _submitted = true);
    final fieldsValid = _formKey.currentState!.validate();
    if (!fieldsValid || _photo == null) return;

    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final now = DateTime.now();
    final cat = widget.cat;

    if (cat == null) {
      placeholderCats.add(
        Cat(
          id: 'NEW-${now.millisecondsSinceEpoch}',
          name: name,
          zone: _zone!,
          colour: _colour ?? '',
          description: description,
          lastSeen: now,
          lastSeenPlace: _zone!,
          photo: _photo!,
          mapPosition: campusSpots['Campus Centre']!,
        ),
      );
    } else {
      cat.name = name;
      cat.zone = _zone!;
      cat.colour = _colour ?? '';
      cat.description = description;
      cat.photo = _photo!;
    }
    Navigator.pop(context);
  }

  Future<void> _remove(Cat cat) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Remove ${cat.name} from the directory?',
          style: AppTextStyles.itemTitle,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Remove',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    placeholderCats.remove(cat);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final cat = widget.cat;

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (cat != null)
            TextButton(
              onPressed: () => _remove(cat),
              child: const Text(
                'Remove from directory',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
        actionsPadding: const EdgeInsets.only(right: AppSpacing.small),
      ),
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
                      const Text('ADMIN', style: AppTextStyles.label),
                      const SizedBox(height: AppSpacing.tiny),
                      Text(
                        cat == null ? 'Add cat' : 'Edit cat',
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: AppSpacing.large),
                      // Photo
                      PhotoBox(
                        photo: _photo,
                        showError: _submitted && _photo == null,
                        onAdd: () => setState(
                          () => _photo = 'assets/images/cats/SU-008.jpg',
                        ),
                        onRemove: () => setState(() => _photo = null),
                      ),
                      const SizedBox(height: AppSpacing.large),
                      // Fields
                      AppTextField(
                        label: 'Name',
                        controller: _nameController,
                        validator: (value) => (value ?? '').trim().isEmpty
                            ? 'Enter a name.'
                            : null,
                      ),
                      const SizedBox(height: AppSpacing.large),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _Dropdown(
                              label: 'ZONE',
                              value: _zone,
                              options: catZones,
                              onChanged: (value) => _zone = value,
                              validator: (value) =>
                                  value == null ? 'Choose a zone.' : null,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.pagePadding),
                          Expanded(
                            child: _Dropdown(
                              label: 'COLOUR',
                              value: _colour,
                              options: catColours,
                              onChanged: (value) => _colour = value,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.large),
                      AppTextField(
                        label: 'Description',
                        controller: _descriptionController,
                        maxLines: 4,
                      ),
                      const SizedBox(height: AppSpacing.large),
                    ],
                  ),
                ),
              ),
              // Action
              Padding(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                child: PrimaryButton(label: 'Save', onPressed: _save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.validator,
  });

  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.small),
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          style: AppTextStyles.body,
          hint: const Text('Choose', style: AppTextStyles.itemSubtitle),
          items: [
            for (final option in options)
              DropdownMenuItem(value: option, child: Text(option)),
          ],
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
