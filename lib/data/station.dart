import 'dart:ui';

class Station {
  Station({
    required this.id,
    required this.name,
    required this.area,
    required this.mapPosition,
    required this.foodHours,
    required this.waterHours,
  });

  final String id;
  final String name;
  final String area;
  final Offset mapPosition;

  // Hours since the last logged refill.
  int foodHours;
  int waterHours;
}
