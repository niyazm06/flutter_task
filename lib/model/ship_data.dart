class ShipsData {
  String? shipId;
  String? shipName;
  String? shipModel;
  String? shipType;
  dynamic roles;
  bool? active;
  int? imo;
  int? mmsi;
  int? abs;
  int? className;
  int? weightLbs;
  int? weightKg;
  int? yearBuilt;
  String? homePort;
  String? status;
  String? speedKn;
  String? courseDeg;
  Position? position;
  dynamic successfulLandings;
  dynamic attemptedLandings;
  List<Missions>? missions;
  String? url;
  String? image;

  ShipsData(
      {this.shipId,
      this.shipName,
      this.shipModel,
      this.shipType,
      this.roles,
      this.active,
      this.imo,
      this.mmsi,
      this.abs,
      this.className,
      this.weightLbs,
      this.weightKg,
      this.yearBuilt,
      this.homePort,
      this.status,
      this.speedKn,
      this.courseDeg,
      this.position,
      this.successfulLandings,
      this.attemptedLandings,
      this.missions,
      this.url,
      this.image});

  ShipsData.fromJson(Map<String, dynamic> json) {
    shipId = json['ship_id'];
    shipName = json['ship_name'];
    shipModel = json['ship_model'];
    shipType = json['ship_type'];
    roles = json['roles'];
    active = json['active'];
    imo = json['imo'];
    mmsi = json['mmsi'];
    abs = json['abs'];
    className = json['class'];
    weightLbs = json['weight_lbs'];
    weightKg = json['weight_kg'];
    yearBuilt = json['year_built'];
    homePort = json['home_port'];
    status = json['status'];
    speedKn = json['speed_kn'];
    courseDeg = json['course_deg'];
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
    successfulLandings = json['successful_landings'];
    attemptedLandings = json['attempted_landings'];
    if (json['missions'] != null) {
      missions = <Missions>[];
      json['missions'].forEach((v) {
        missions!.add(Missions.fromJson(v));
      });
    }
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ship_id'] = shipId;
    data['ship_name'] = shipName;
    data['ship_model'] = shipModel;
    data['ship_type'] = shipType;
    data['roles'] = roles;
    data['active'] = active;
    data['imo'] = imo;
    data['mmsi'] = mmsi;
    data['abs'] = abs;
    data['class'] = className;
    data['weight_lbs'] = weightLbs;
    data['weight_kg'] = weightKg;
    data['year_built'] = yearBuilt;
    data['home_port'] = homePort;
    data['status'] = status;
    data['speed_kn'] = speedKn;
    data['course_deg'] = courseDeg;
    if (position != null) {
      data['position'] = position!.toJson();
    }
    data['successful_landings'] = successfulLandings;
    data['attempted_landings'] = attemptedLandings;
    if (missions != null) {
      data['missions'] = missions!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    data['image'] = image;
    return data;
  }
}

class Position {
  String? latitude;
  String? longitude;

  Position({this.latitude, this.longitude});

  Position.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Missions {
  String? name;
  int? flight;

  Missions({this.name, this.flight});

  Missions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    flight = json['flight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['flight'] = flight;
    return data;
  }
}
