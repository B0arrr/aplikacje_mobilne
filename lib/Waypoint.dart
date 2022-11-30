class Waypoint {
  String name;
  double long;
  double lat;
  String task;

  Waypoint(
      this.name,
      this.long,
      this.lat,
      this.task
      );

  Waypoint.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        lat = json['Latitude'],
        long = json['Longitude'],
        task = json['Task'];
}