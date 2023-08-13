import 'dart:convert';

class UserLocations {
  const UserLocations({
      this.id,
      this.userId,
      this.name,
      this.coordinates,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
  });
  
  factory UserLocations.fromMap(Map<String, dynamic> map) => UserLocations(
      id: map['id'],
      userId: map['user_id'],
      name: map['name'] == null ? null : Name.fromMap(map['name']),
      coordinates: map['coordinates'] == null ? null : Coordinates.fromMap(map['coordinates']),
      type: map['type'],
      status: map['status'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
  );
  
  factory UserLocations.fromJson(String str) => UserLocations.fromMap(json.decode(str));
  
  final int? id;
  final int? userId;
  final Name? name;
  final Coordinates? coordinates;
  final String? type;
  final bool? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  
  Map<String, dynamic> toMap() => {
      'id': id,
      'user_id': userId,
      'name': name?.toMap(),
      'coordinates': coordinates?.toMap(),
      'type': type,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
  };
  
  String toJson() => json.encode(toMap());
  
  UserLocations copyWith({
      int? id,
      int? userId,
      Name? name,
      Coordinates? coordinates,
      String? type,
      bool? status,
      String? createdAt,
      String? updatedAt,
      dynamic? deletedAt,
  }) => UserLocations(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      coordinates: coordinates ?? this.coordinates,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
  );
  
  @override
  String toString() => 'UserLocations(id: $id, userId: $userId, name: $name, coordinates: $coordinates, type: $type, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  
}

class Coordinates {
  const Coordinates({this.latitude, this.longitude});
  
  factory Coordinates.fromMap(Map<String, dynamic> map) => Coordinates(
      latitude: map['latitude'],
      longitude: map['longitude'],
  );
  
  factory Coordinates.fromJson(String str) => Coordinates.fromMap(json.decode(str));
  
  final String? latitude;
  final String? longitude;
  
  Map<String, dynamic> toMap() => {
      'latitude': latitude,
      'longitude': longitude,
  };
  
  String toJson() => json.encode(toMap());
  
  Coordinates copyWith({String? latitude, String? longitude}) => Coordinates(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
  );
  
  @override
  String toString() => 'Coordinates(latitude: $latitude, longitude: $longitude)';
  
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
  
  Name copyWith({
      String? azName,
      String? ruName,
      String? enName,
      String? trName,
  }) => Name(
      azName: azName ?? this.azName,
      ruName: ruName ?? this.ruName,
      enName: enName ?? this.enName,
      trName: trName ?? this.trName,
  );
  
  @override
  String toString() => 'Name(azName: $azName, ruName: $ruName, enName: $enName, trName: $trName)';
  
}

