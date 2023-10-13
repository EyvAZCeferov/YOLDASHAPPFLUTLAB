import 'dart:convert';

import 'package:yoldashapp/models/automobils.dart';
import 'package:yoldashapp/models/users.dart';

class Rides {
  const Rides({
    this.id,
    this.userId,
    this.automobilId,
    this.coordinates,
    this.polylinePoints,
    this.startTime,
    this.endTime,
    this.kmofway,
    this.durationofway,
    this.minimalPriceOfWay,
    this.priceOfWay,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.queries,
    this.automobil,
    this.user,
  });

  factory Rides.fromMap(Map<String, dynamic> map) => Rides(
        id: map['id'],
        userId: map['user_id'],
        automobilId: map['automobil_id'],
        coordinates: map['coordinates'] == null
            ? null
            : List<CoordinatesRides>.from(
                map['coordinates'].map((e) => CoordinatesRides.fromMap(e))),
        polylinePoints: (map['polyline_points'] as List<dynamic>)
            .map((pointList) => pointList
                .map((point) => double.parse(point.toString()))
                .toList())
            .toList(),
        startTime: map['start_time'],
        endTime: map['end_time'],
        kmofway: map['kmofway'],
        durationofway: map['durationofway'],
        minimalPriceOfWay: map['minimal_price_of_way'],
        priceOfWay: map['price_of_way'],
        paymentMethod: map['payment_method'],
        status: map['status'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        deletedAt: map['deleted_at'],
        queries: map['queries'] == null
            ? null
            : List<Queries>.from(map['queries'].map((e) => Queries.fromMap(e))),
        automobil: map['automobil'] == null
            ? null
            : Automobils.fromMap(map['automobil']),
        user: map['user'] == null ? null : Users.fromMap(map['user']),
      );

  factory Rides.fromJson(String str) => Rides.fromMap(json.decode(str));

  final int? id;
  final int? userId;
  final int? automobilId;
  final List<CoordinatesRides>? coordinates;
  final List? polylinePoints;
  final int? startTime;
  final int? endTime;
  final String? kmofway;
  final String? durationofway;
  final String? minimalPriceOfWay;
  final String? priceOfWay;
  final String? paymentMethod;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final List<Queries>? queries;
  final Automobils? automobil;
  final Users? user;

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'automobil_id': automobilId,
        'coordinates': coordinates?.map((e) => e?.toMap()).toList(),
        'polyline_points': polylinePoints,
        'start_time': startTime,
        'end_time': endTime,
        'kmofway': kmofway,
        'durationofway': durationofway,
        'minimal_price_of_way': minimalPriceOfWay,
        'price_of_way': priceOfWay,
        'payment_method': paymentMethod,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'queries': queries?.map((e) => e?.toMap()).toList(),
        'automobil': automobil?.toMap(),
        'user': user?.toMap(),
      };

  String toJson() => json.encode(toMap());
}

class Queries {
  const Queries({
    this.id,
    this.rideId,
    this.userId,
    this.driverId,
    this.riderId,
    this.status,
    this.price,
    this.priceEndirim,
    this.weight,
    this.position,
    this.gender,
    this.coordinates,
    this.kmofway,
    this.durationofway,
    this.reasonId,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.rider,
    this.reason,
    this.ratingRide,
    this.place,
    this.usedEndirim
  });

  factory Queries.fromMap(Map<String, dynamic> map) => Queries(
        id: map['id'],
        rideId: map['ride_id'],
        userId: map['user_id'],
        driverId: map['driver_id'],
        riderId: map['rider_id'],
        status: map['status'],
        price: map['price'],
        priceEndirim:map['price_endirim'],
        weight: map['weight'],
        position: map['position'],
        gender: map['gender'],
        coordinates: map['coordinates'] == null ? null : List<CoordinatesRides>.from(map['coordinates'].map((e) => CoordinatesRides.fromMap(e))),
        kmofway: map['kmofway'],
        durationofway: map['durationofway'],
        reasonId: map['reason_id'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        driver: map['driver'] == null ? null : Users.fromMap(map['driver']),
        rider: map['rider'] == null ? null : Users.fromMap(map['rider']),
        reason: map['reason'],
        ratingRide: map['rating_ride'],
        place: map['place'] == null ? null : PlacesMark.fromMap(map['place']),
        usedEndirim:map['used_endirim']
      );

  factory Queries.fromJson(String str) => Queries.fromMap(json.decode(str));

  final int? id;
  final int? rideId;
  final int? userId;
  final int? driverId;
  final int? riderId;
  final String? status;
  final String? price;
  final String? priceEndirim;
  final String? weight;
  final int? position;
  final int? gender;
  final List<CoordinatesRides>? coordinates;
  final String? kmofway;
  final String? durationofway;
  final int? reasonId;
  final String? createdAt;
  final String? updatedAt;
  final Users? driver;
  final Users? rider;
  final Reason? reason;
  final int? ratingRide;
  final PlacesMark? place;
  final String? usedEndirim;

  Map<String, dynamic> toMap() => {
        'id': id,
        'ride_id': rideId,
        'user_id': userId,
        'driver_id': driverId,
        'rider_id': riderId,
        'status': status,
        'price': price,
        'price_endirim':priceEndirim,
        'weight': weight,
        'position': position,
        'gender': gender,
        'coordinates': coordinates?.map((e) => e?.toMap()).toList(),
        'kmofway': kmofway,
        'durationofway': durationofway,
        'reason_id': reasonId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'driver': driver?.toMap(),
        'rider': rider,
        'reason': reason,
        'rating_ride': ratingRide,
        'place': place?.toMap(),
        'used_endirim':usedEndirim,
      };

  String toJson() => json.encode(toMap());
}

class Reason {
  const Reason({
    this.id,
    this.name,
    this.slugs,
    this.order,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Reason.fromMap(Map<String, dynamic> map) => Reason(
        id: map['id'],
        name: map['name'] == null ? null : Name.fromMap(map['name']),
        slugs: map['slugs'] == null ? null : Slugs.fromMap(map['slugs']),
        order: map['order'],
        status: map['status'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        deletedAt: map['deleted_at'],
      );

  factory Reason.fromJson(String str) => Reason.fromMap(json.decode(str));

  final int? id;
  final Name? name;
  final Slugs? slugs;
  final int? order;
  final bool? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        "name": name?.toMap(),
        "slugs": slugs?.toMap(),
        "order": order,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  String toJson() => json.encode(toMap());
}

class CoordinatesRides {
  const CoordinatesRides({
    this.latitude,
    this.longitude,
    this.address,
    this.type,
  });

  factory CoordinatesRides.fromMap(Map<String, dynamic> map) =>
      CoordinatesRides(
        latitude: map['latitude'],
        longitude: map['longitude'],
        address: map['address'],
        type: map['type'],
      );

  factory CoordinatesRides.fromJson(String str) =>
      CoordinatesRides.fromMap(json.decode(str));

  final String? latitude;
  final String? longitude;
  final String? address;
  final String? type;

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'type': type,
      };

  Map<String, dynamic> toJsonMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'type': type,
    };
  }

  String toJson() => json.encode(toMap());
}
