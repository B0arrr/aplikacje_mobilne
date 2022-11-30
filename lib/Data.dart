import 'Waypoint.dart';

class Data {
  List<Waypoint> waypoints;

  Data(this.waypoints);

  Data.fromJson(List<dynamic> json)
      : waypoints = json
          .map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
          .toList();
}