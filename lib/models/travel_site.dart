import "dart:convert";

TravelSite travelSiteFromJson(String str) => TravelSite.fromJson(json.decode(str));
String travelSiteToJson(TravelSite data) => json.encode(data.toJson());

class TravelSite {
  int id;
  String name;
  String detail;
  String coverimage;
  double latitude;
  double longitude;
  DateTime createdAt;

  TravelSite({
    required this.id,
    required this.name,
    required this.detail,
    required this.coverimage,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  factory TravelSite.fromJson(Map<String, dynamic> json) => TravelSite(
    id: json["id"],
    name: json["name"],
    detail: json["detail"],
    coverimage: json["coverimage"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "detail": detail,
    "coverimage": coverimage,
    "latitude": latitude,
    "longitude": longitude,
    "createdAt": createdAt.toIso8601String(),
  };
}
