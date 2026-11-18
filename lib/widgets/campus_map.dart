import 'package:material_ui/material_ui.dart';

class MapMarker {
  const MapMarker({required this.position, required this.child});

  final Offset position;
  final Widget child;
}

class CampusMap extends StatelessWidget {
  const CampusMap({super.key, required this.markers, this.onTap});

  final List<MapMarker> markers;
  final ValueChanged<Offset>? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 632 / 1134,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            return GestureDetector(
              onTapDown: onTap == null
                  ? null
                  : (details) => onTap!(
                      Offset(
                        (details.localPosition.dx / size.width).clamp(0, 1),
                        (details.localPosition.dy / size.height).clamp(0, 1),
                      ),
                    ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/campus_map.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  for (final marker in markers)
                    Positioned(
                      left: marker.position.dx * size.width,
                      top: marker.position.dy * size.height,
                      child: FractionalTranslation(
                        translation: const Offset(-0.5, -0.5),
                        child: marker.child,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
