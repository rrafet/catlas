String signedInEmail = '';

String get displayName {
  final name = signedInEmail.split('@').first.split('.').first;
  if (name.isEmpty) return '';
  return name[0].toUpperCase() + name.substring(1);
}
