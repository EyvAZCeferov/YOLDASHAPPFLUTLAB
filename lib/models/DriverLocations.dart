import 'dart:convert';

import 'package:yoldashapp/models/automobils.dart';
import 'package:yoldashapp/models/user_locations.dart';

class DriverLocations {
  const DriverLocations({
      this.id,
      this.coordinates,
      this.model,
      this.marka,
      this.name,
      this.mapIcon,
      this.places,
      this.nameSurname,
  });
  
  factory DriverLocations.fromMap(Map<String, dynamic> map) => DriverLocations(
      id: map['id'],
      coordinates: map['coordinates'] == null ? null : Coordinates.fromMap(map['coordinates']),
      model: map['model'],
      marka: map['marka'],
      name: map['name'] == null ? null : Name.fromMap(map['name']),
      mapIcon: map['map_icon'],
      places: map['places'],
      nameSurname: map['name_surname'],
  );
  
  factory DriverLocations.fromJson(String str) => DriverLocations.fromMap(json.decode(str));
  
  final int? id;
  final Coordinates? coordinates;
  final String? model;
  final String? marka;
  final Name? name;
  final String? mapIcon;
  final int? places;
  final String? nameSurname;
  
  Map<String, dynamic> toMap() => {
      'id': id,
      'coordinates': coordinates?.toMap(),
      'model': model,
      'marka': marka,
      'name': name?.toMap(),
      'map_icon': mapIcon,
      'places': places,
      'name_surname': nameSurname,
  };
  
  String toJson() => json.encode(toMap());
  
}


