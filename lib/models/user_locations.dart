import 'dart:convert';

class UserLocations {
  const UserLocations({
      this.id,
      this.userId,
      this.placeId,
      this.name,
      this.coordinates,
      this.type,
      this.status,
      this.orderNumber,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
  });
  
  factory UserLocations.fromMap(Map<String, dynamic> map) => UserLocations(
      id: map['id'],
      userId: map['user_id'],
      placeId: map['place_id'],
      name: map['name'] == null ? null : Name.fromMap(map['name']),
      coordinates: map['coordinates'] == null ? null : Coordinates.fromMap(map['coordinates']),
      type: map['type'],
      status: map['status'],
      orderNumber:map['order_number'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
  );
  
  factory UserLocations.fromJson(Map<String, dynamic> map) {
    return UserLocations(
      id: map['id'],
      userId: map['user_id'],
      placeId: map['place_id'],
      name: map['name'] == null ? null : Name.fromMap(map['name']),
      coordinates: map['coordinates'] == null ? null : Coordinates.fromMap(map['coordinates']),
      type: map['type'],
      status: map['status'],
      orderNumber:map['order_number'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
    );
  }
  
  final int? id;
  final int? userId;
  final String? placeId;
  final Name? name;
  final Coordinates? coordinates;
  final String? type;
  final bool? status;
  final int? orderNumber;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  
  Map<String, dynamic> toMap() => {
      'id': id,
      'user_id': userId,
      'place_id': placeId,
      'name': name?.toMap(),
      'coordinates': coordinates?.toMap(),
      'type': type,
      'status': status,
      'order_number':orderNumber,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
  };
  
  String toJson() => json.encode(toMap());
  
}

class Coordinates {
  const Coordinates({this.latitude, this.longitude});
  
  factory Coordinates.fromMap(Map<String, dynamic> map) => Coordinates(
      latitude: map['latitude'],
      longitude: map['longitude'],
  );
  
  factory Coordinates.fromJson(String str) => Coordinates.fromMap(json.decode(str));
  
  final double? latitude;
  final double? longitude;
  
  Map<String, dynamic> toMap() => {
      'latitude': latitude,
      'longitude': longitude,
  };
  
  String toJson() => json.encode(toMap());
  
}

class Name {
  const Name({
      this.azName,
      this.ruName,
      this.enName,
      this.trName,
  });
  
  factory Name.fromMap(Map<String, dynamic> map) => Name(
      azName: map['az_name'],
      ruName: map['ru_name'],
      enName: map['en_name'],
      trName: map['tr_name'],
  );
  
  factory Name.fromJson(String str) => Name.fromMap(json.decode(str));
  
  final String? azName;
  final String? ruName;
  final String? enName;
  final String? trName;
  
  Map<String, dynamic> toMap() => {
      'az_name': azName,
      'ru_name': ruName,
      'en_name': enName,
      'tr_name': trName,
  };
  
  String toJson() => json.encode(toMap());
  
}

