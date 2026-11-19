import 'dart:ui';

class Cat {
  Cat({
    required this.id,
    required this.name,
    required this.zone,
    required this.lastSeen,
    required this.lastSeenPlace,
    required this.photo,
    required this.mapPosition,
  });

  final String id;
  final String name;
  final String zone;
  final String photo;

  // Updated when someone logs a newer sighting.
  DateTime lastSeen;
  String lastSeenPlace;
  Offset mapPosition;
}

String timeAgo(DateTime time) {
  final difference = DateTime.now().difference(time);
  if (difference.inMinutes < 1) return 'just now';
  if (difference.inMinutes < 60) return '${difference.inMinutes} min ago';
  if (difference.inHours < 24) return '${difference.inHours} h ago';
  if (difference.inDays < 2) return 'yesterday';
  return '${difference.inDays} days ago';
}
