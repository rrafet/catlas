import 'dart:ui';

class Station {
  const Station({
    required this.id,
    required this.name,
    required this.mapPosition,
    required this.lastFood,
    required this.lastWater,
  });

  final String id;
  final String name;
  final Offset mapPosition;
  final String lastFood;
  final String lastWater;
}
