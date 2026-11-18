import 'dart:ui';

class Cat {
  const Cat({
    required this.id,
    required this.name,
    required this.zone,
    required this.lastSeen,
    required this.photo,
    required this.mapPosition,
  });

  final String id;
  final String name;
  final String zone;
  final String lastSeen;
  final String photo;
  final Offset mapPosition;
}
