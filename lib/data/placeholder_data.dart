import 'dart:ui';

import 'cat.dart';
import 'station.dart';

const String joinCode = 'SUCATS';
const String orgName = 'Sabancı University';

const Map<String, Offset> campusSpots = {
  'UC': Offset(0.65, 0.18),
  'FMAN': Offset(0.22, 0.34),
  'FENS': Offset(0.92, 0.38),
  'Campus Centre': Offset(0.47, 0.50),
  'FASS': Offset(0.91, 0.72),
  'SL': Offset(0.06, 0.82),
};

const List<Cat> placeholderCats = [
  Cat(
    id: 'SU-001',
    name: 'Balım',
    zone: 'Library',
    lastSeen: '40 min ago',
    photo: 'assets/images/cats/SU-001.jpg',
    mapPosition: Offset(0.20, 0.55),
  ),
  Cat(
    id: 'SU-002',
    name: 'Ebru',
    zone: 'FENS',
    lastSeen: '2 h ago',
    photo: 'assets/images/cats/SU-002.jpg',
    mapPosition: Offset(0.88, 0.45),
  ),
  Cat(
    id: 'SU-003',
    name: 'Hero',
    zone: 'FASS',
    lastSeen: '3 h ago',
    photo: 'assets/images/cats/SU-003.jpg',
    mapPosition: Offset(0.85, 0.80),
  ),
  Cat(
    id: 'SU-004',
    name: 'Zeytin',
    zone: 'Dorms',
    lastSeen: '5 h ago',
    photo: 'assets/images/cats/SU-004.jpg',
    mapPosition: Offset(0.40, 0.30),
  ),
  Cat(
    id: 'SU-005',
    name: 'Köpük',
    zone: 'Dorms',
    lastSeen: '8 h ago',
    photo: 'assets/images/cats/SU-005.jpg',
    mapPosition: Offset(0.15, 0.90),
  ),
];

const List<Station> placeholderStations = [
  Station(
    id: 'ST-001',
    name: 'UC Garden',
    mapPosition: Offset(0.55, 0.25),
    lastFood: '3 h ago',
    lastWater: '1 h ago',
  ),
  Station(
    id: 'ST-002',
    name: 'FENS Entrance',
    mapPosition: Offset(0.78, 0.42),
    lastFood: '9 h ago',
    lastWater: '5 h ago',
  ),
  Station(
    id: 'ST-003',
    name: 'SL Corner',
    mapPosition: Offset(0.12, 0.76),
    lastFood: '26 h ago',
    lastWater: '14 h ago',
  ),
];
