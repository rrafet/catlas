import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../data/placeholder_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cat_photo.dart';
import '../../widgets/primary_button.dart';
import '../map/pick_location_screen.dart';

class NewSightingScreen extends StatefulWidget {
  const NewSightingScreen({super.key, this.initialCat});

  final Cat? initialCat;

  @override
  State<NewSightingScreen> createState() => _NewSightingScreenState();
}

class _NewSightingScreenState extends State<NewSightingScreen> {
  Cat? _cat;
  String? _location;
  DateTime _time = DateTime.now();
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _cat = widget.initialCat;
  }

  bool get _timeInFuture => _time.isAfter(DateTime.now());

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

  Future<void> _chooseTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_time),
    );
    if (picked != null) {
      final now = DateTime.now();
      setState(() {
        _time = DateTime(
          now.year,
          now.month,
          now.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  void _save() {
    setState(() => _submitted = true);
    if (_location == null || _timeInFuture) return;

    final cat = _cat;
    // An older sighting must not replace a newer one.
    if (cat != null && _time.isAfter(cat.lastSeen)) {
      cat.lastSeen = _time;
      cat.lastSeenPlace = _location!;
      cat.mapPosition = campusSpots[_location]!;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cat = _cat;
    final timeText = MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(_time),
      alwaysUse24HourFormat: true,
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                    const Text('New sighting', style: AppTextStyles.title),
                    const SizedBox(height: AppSpacing.large),
                    // Cat
                    const Text(
                      'WHICH CAT?  (optional)',
                      style: AppTextStyles.label,
                    ),
                    const SizedBox(height: AppSpacing.small),
                    Row(
                      children: [
                        if (cat != null) ...[
                          CatPhoto(photo: cat.photo, size: 40),
                          const SizedBox(width: AppSpacing.medium),
                        ],
                        Expanded(
                          child: cat == null
                              ? const Text(
                                  'Not in the directory',
                                  style: AppTextStyles.itemSubtitle,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cat.name,
                                      style: AppTextStyles.itemTitle,
                                    ),
                                    Text(
                                      cat.zone,
                                      style: AppTextStyles.itemSubtitle,
                                    ),
                                  ],
                                ),
                        ),
                        TextButton(
                          onPressed: _chooseCat,
                          child: Text(cat == null ? 'Choose' : 'Change'),
                        ),
                      ],
                    ),
                    if (cat != null)
                      TextButton(
                        onPressed: () => setState(() => _cat = null),
                        child: const Text(
                          'Not in the directory',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.large),
                    // Location
                    const Text('LOCATION', style: AppTextStyles.label),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _location ?? 'Not set',
                            style: _location == null
                                ? AppTextStyles.itemSubtitle
                                : AppTextStyles.body,
                          ),
                        ),
                        TextButton(
                          onPressed: _chooseLocation,
                          child: const Text('Pick on map'),
                        ),
                      ],
                    ),
                    if (_submitted && _location == null)
                      const Text(
                        'Pick where you saw the cat.',
                        style: TextStyle(color: AppColors.error),
                      ),
                    const SizedBox(height: AppSpacing.large),
                    // Time
                    const Text('TIME', style: AppTextStyles.label),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Today, $timeText',
                            style: AppTextStyles.heading,
                          ),
                        ),
                        TextButton(
                          onPressed: _chooseTime,
                          child: const Text('Change'),
                        ),
                      ],
                    ),
                    if (_submitted && _timeInFuture)
                      const Text(
                        "This time hasn't happened yet.",
                        style: TextStyle(color: AppColors.error),
                      ),
                    const SizedBox(height: AppSpacing.large),
                  ],
                ),
              ),
            ),
            // Action
            Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: PrimaryButton(label: 'Save sighting', onPressed: _save),
            ),
          ],
        ),
      ),
    );
  }
}
