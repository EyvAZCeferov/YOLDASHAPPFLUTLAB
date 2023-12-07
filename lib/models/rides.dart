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
    this.paymentCard,
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
        polylinePoints: map['polyline_points']==null ? null : (map['polyline_points'] as List<dynamic>)
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
        paymentCard: map['payment_card'],
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
  final dynamic? startTime;
  final dynamic? endTime;
  final dynamic? kmofway;
  final dynamic? durationofway;
  final dynamic? minimalPriceOfWay;
  final dynamic? priceOfWay;
  final dynamic? paymentMethod;
  final int? paymentCard;
  final dynamic? status;
  final dynamic? createdAt;
  final dynamic? updatedAt;
  final dynamic? deletedAt;
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
        'payment_card': paymentCard,
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
    this.driver,
    this.rider,
    this.reason,
    this.ratingRide,
    this.place,
    this.usedEndirim,
    this.endirim,
    this.paymentMethod,
    this.paymentCard,
    this.createdAt,
    this.updatedAt,
    
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
        reason: map['reason'] == null ? null : Reason.fromMap(map['reason']),
        ratingRide: map['rating_ride'],
        place: map['place'] == null ? null : PlacesMark.fromMap(map['place']),
        usedEndirim:map['used_endirim'],
        endirim: map['endirim'] == null ? null : Endirim.fromMap(map['endirim']),
        paymentMethod: map['payment_method'],
        paymentCard: map['payment_card'],
      );

  factory Queries.fromJson(String str) => Queries.fromMap(json.decode(str));

  final int? id;
  final int? rideId;
  final int? userId;
  final int? driverId;
  final int? riderId;
  final dynamic? status;
  final dynamic? price;
  final dynamic? priceEndirim;
  final dynamic? weight;
  final dynamic? position;
  final dynamic? gender;
  final List<CoordinatesRides>? coordinates;
  final dynamic? kmofway;
  final dynamic? durationofway;
  final int? reasonId;
  final dynamic? createdAt;
  final dynamic? updatedAt;
  final Users? driver;
  final Users? rider;
  final Reason? reason;
  final int? ratingRide;
  final PlacesMark? place;
  final int? usedEndirim;
  final Endirim? endirim;
  final dynamic? paymentMethod;
  final int? paymentCard;

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
        'reason': reason?.toMap(),
        'rating_ride': ratingRide,
        'place': place?.toMap(),
        'used_endirim':usedEndirim,
        'endirim': endirim?.toMap(),
        'paymentMethod': paymentMethod,
        'paymentCard': paymentCard,
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
  final dynamic? createdAt;
  final dynamic? updatedAt;
  final dynamic? deletedAt;

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

  final dynamic? latitude;
  final dynamic? longitude;
  final dynamic? address;
  final dynamic? type;

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

class Endirim {
  const Endirim({
    this.id,
    this.uuid,
    this.value,
    this.type,
    this.status,
    this.applyToGroup,
    this.sendnotification,
    this.createdAt,
    this.updatedAt,
  });

  factory Endirim.fromMap(Map<String, dynamic> map) =>
      Endirim(
        id: map['id'],
        uuid: map['uuid'],
        value: map['value'],
        type: map['type'],
        status: map['status'],
        applyToGroup: map['apply_to_group'],
        sendnotification: map['sendnotification'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
      );

  factory Endirim.fromJson(String str) =>
      Endirim.fromMap(json.decode(str));

  final int? id;
  final dynamic? uuid;
  final int? value;
  final dynamic? type;
  final bool? status;
  final bool? sendnotification;
  final dynamic? applyToGroup;
  final dynamic? createdAt;
  final dynamic? updatedAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'uuid': uuid,
        'value': value,
        'type': type,
        'status': status,
        'sendnotification': sendnotification,
        'apply_to_group': applyToGroup,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  Map<String, dynamic> toJsonMap() {
    return {
       'id': id,
        'uuid': uuid,
        'value': value,
        'type': type,
        'status': status,
        'sendnotification': sendnotification,
        'apply_to_group': applyToGroup,
        'created_at': createdAt,
        'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
}
