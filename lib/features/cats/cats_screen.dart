import 'package:material_ui/material_ui.dart';

import '../../data/cat.dart';
import '../../data/placeholder_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/cat_card.dart';
import 'cat_profile_screen.dart';

const List<String> _zones = ['All', 'FENS', 'FASS', 'Library', 'Dorms'];

String _normalize(String text) {
  const replacements = {
    'ç': 'c',
    'Ç': 'c',
    'ğ': 'g',
    'Ğ': 'g',
    'ı': 'i',
    'İ': 'i',
    'ö': 'o',
    'Ö': 'o',
    'ş': 's',
    'Ş': 's',
    'ü': 'u',
    'Ü': 'u',
  };
  var result = text;
  replacements.forEach((from, to) => result = result.replaceAll(from, to));
  return result.toLowerCase();
}

class CatsScreen extends StatefulWidget {
  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  final List<Cat> _cats = List.of(placeholderCats);
  String _query = '';
  String _selectedZone = 'All';

  List<Cat> get _visibleCats {
    final query = _normalize(_query);
    return _cats
        .where((cat) => _selectedZone == 'All' || cat.zone == _selectedZone)
        .where((cat) => _normalize(cat.name).contains(query))
        .toList();
  }

  void _removeCat(Cat cat) {
    setState(() => _cats.remove(cat));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('${cat.name} removed')));
  }

  Future<void> _openProfile(Cat cat) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CatProfileScreen(cat: cat)),
    );
    // A sighting logged from the profile may have changed "Seen ...".
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final visibleCats = _visibleCats;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          children: [
            // Header
            const Text('Cats', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.large),
            // Search
            TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                hintText: 'Search by name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            // Zones
            Wrap(
              spacing: AppSpacing.medium,
              runSpacing: AppSpacing.small,
              children: [
                for (final zone in _zones)
                  _ZoneTab(
                    label: zone,
                    selected: zone == _selectedZone,
                    onTap: () => setState(() => _selectedZone = zone),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.large),
            Text(
              visibleCats.length == 1 ? '1 cat' : '${visibleCats.length} cats',
              style: AppTextStyles.itemSubtitle,
            ),
            const SizedBox(height: AppSpacing.small),
            // List
            if (visibleCats.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.large),
                child: Center(
                  child: Text(
                    'No cats found',
                    style: AppTextStyles.itemSubtitle,
                  ),
                ),
              ),
            for (final cat in visibleCats)
              Dismissible(
                key: ValueKey(cat.id),
                direction: DismissDirection.endToStart,
                background: const _RemoveBackground(),
                onDismissed: (_) => _removeCat(cat),
                child: CatCard(cat: cat, onTap: () => _openProfile(cat)),
              ),
          ],
        ),
      ),
    );
  }
}

class _ZoneTab extends StatelessWidget {
  const _ZoneTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: AppSpacing.tiny),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? AppColors.accent : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: selected
              ? AppTextStyles.itemSubtitle.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                )
              : AppTextStyles.itemSubtitle,
        ),
      ),
    );
  }
}

class _RemoveBackground extends StatelessWidget {
  const _RemoveBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textPrimary,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.delete_outline, color: AppColors.onPrimary),
          const SizedBox(height: AppSpacing.tiny),
          Text(
            'Remove',
            style: AppTextStyles.body.copyWith(color: AppColors.onPrimary),
          ),
        ],
      ),
    );
  }
}
