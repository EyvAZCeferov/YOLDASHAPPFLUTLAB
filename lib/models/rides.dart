import "dart:convert";

import "package:yoldashapp/models/users.dart";

import "automobils.dart";

class Rides {
  const Rides({
    this.id,
    this.creatorId,
    this.automobilId,
    this.fromCoordinates,
    this.toCoordinates,
    this.startTime,
    this.endTime,
    this.kmofway,
    this.minimalPriceOfWay,
    this.priceOfWay,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.queries,
    this.automobil,
    this.creator,
    this.ridedetails,
    this.payments,
  });

  factory Rides.fromMap(Map<String, dynamic> map) => Rides(
        id: map["id"],
        creatorId: map["creator_id"],
        automobilId: map["automobil_id"],
        fromCoordinates: map["from_coordinates"] == null
            ? null
            : GETCOORDINATES.fromMap(map["from_coordinates"]),
        toCoordinates: map["to_coordinates"] == null
            ? null
            : GETCOORDINATES.fromMap(map["to_coordinates"]),
        startTime: map["start_time"],
        endTime: map["end_time"],
        kmofway: map["kmofway"],
        minimalPriceOfWay: map["minimal_price_of_way"],
        priceOfWay: map["price_of_way"],
        paymentMethod: map["payment_method"],
        status: map["status"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
        queries:
            map["queries"] == null ? null : List<dynamic>.from(map["queries"]),
        automobil: map["automobil"] == null
            ? null
            : Automobil.fromMap(map["automobil"]),
        creator:
            map["creator"] == null ? null : Users.fromMap(map["creator"]),
        ridedetails: map["ridedetails"] == null
            ? null
            : List<Ridedetails>.from(
                map["ridedetails"].map((e) => Ridedetails.fromMap(e))),
        payments: map["payments"] == null
            ? null
            : List<dynamic>.from(map["payments"]),
      );

  factory Rides.fromJson(String str) => Rides.fromMap(json.decode(str));

  final int? id;
  final int? creatorId;
  final int? automobilId;
  final GETCOORDINATES? fromCoordinates;
  final GETCOORDINATES? toCoordinates;
  final dynamic? startTime;
  final dynamic? endTime;
  final String? kmofway;
  final String? minimalPriceOfWay;
  final String? priceOfWay;
  final String? paymentMethod;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic? deletedAt;
  final List<dynamic>? queries;
  final Automobil? automobil;
  final Users? creator;
  final List<Ridedetails>? ridedetails;
  final List<dynamic>? payments;

  Map<String, dynamic> toMap() => {
        "id": id,
        "creator_id": creatorId,
        "automobil_id": automobilId,
        "from_coordinates": fromCoordinates?.toMap(),
        "to_coordinates": toCoordinates?.toMap(),
        "start_time": startTime,
        "end_time": endTime,
        "kmofway": kmofway,
        "minimal_price_of_way": minimalPriceOfWay,
        "price_of_way": priceOfWay,
        "payment_method": paymentMethod,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "queries": queries?.map((e) => e).toList(),
        "automobil": automobil?.toMap(),
        "creator": creator?.toMap(),
        "ridedetails": ridedetails?.map((e) => e?.toMap()).toList(),
        "payments": payments?.map((e) => e).toList(),
      };

  String toJson() => json.encode(toMap());
}

class Ridedetails {
  const Ridedetails({
    this.id,
    this.userId,
    this.rideId,
    this.weight,
    this.placeId,
    this.createdAt,
    this.updatedAt,
    this.ride,
    this.user,
    this.place,
  });

  factory Ridedetails.fromMap(Map<String, dynamic> map) => Ridedetails(
        id: map["id"],
        userId: map["user_id"],
        rideId: map["ride_id"],
        weight: map["weight"],
        placeId: map["place_id"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        ride: map["ride"] == null ? null : Ride.fromMap(map["ride"]),
        user: map["user"] == null ? null : Users.fromMap(map["user"]),
        place: map["place"],
      );

  factory Ridedetails.fromJson(String str) =>
      Ridedetails.fromMap(json.decode(str));

  final int? id;
  final int? userId;
  final int? rideId;
  final String? weight;
  final dynamic placeId;
  final String? createdAt;
  final String? updatedAt;
  final Ride? ride;
  final Users? user;
  final dynamic place;

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "ride_id": rideId,
        "weight": weight,
        "place_id": placeId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "ride": ride?.toMap(),
        "user": user?.toMap(),
        "place": place,
      };

  String toJson() => json.encode(toMap());
}

class Ride {
  const Ride({
    this.id,
    this.creatorId,
    this.automobilId,
    this.fromCoordinates,
    this.toCoordinates,
    this.startTime,
    this.kmofway,
    this.minimalPriceOfWay,
    this.priceOfWay,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Ride.fromMap(Map<String, dynamic> map) => Ride(
        id: map["id"],
        creatorId: map["creator_id"],
        automobilId: map["automobil_id"],
        fromCoordinates: map["from_coordinates"] == null
            ? null
            : GETCOORDINATES.fromMap(map["from_coordinates"]),
        toCoordinates: map["to_coordinates"] == null
            ? null
            : GETCOORDINATES.fromMap(map["to_coordinates"]),
        startTime: map["start_time"],
        kmofway: map["kmofway"],
        minimalPriceOfWay: map["minimal_price_of_way"],
        priceOfWay: map["price_of_way"],
        paymentMethod: map["payment_method"],
        status: map["status"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
      );

  factory Ride.fromJson(String str) => Ride.fromMap(json.decode(str));

  final int? id;
  final int? creatorId;
  final int? automobilId;
  final GETCOORDINATES? fromCoordinates;
  final GETCOORDINATES? toCoordinates;
  final int? startTime;
  final String? kmofway;
  final String? minimalPriceOfWay;
  final String? priceOfWay;
  final String? paymentMethod;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Map<String, dynamic> toMap() => {
        "id": id,
        "creator_id": creatorId,
        "automobil_id": automobilId,
        "from_coordinates": fromCoordinates?.toMap(),
        "to_coordinates": toCoordinates?.toMap(),
        "start_time": startTime,
        "kmofway": kmofway,
        "minimal_price_of_way": minimalPriceOfWay,
        "price_of_way": priceOfWay,
        "payment_method": paymentMethod,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  String toJson() => json.encode(toMap());
}

class RidesElement {
  const RidesElement({
    this.id,
    this.creatorId,
    this.automobilId,
    this.fromCoordinates,
    this.toCoordinates,
    this.startTime,
    this.kmofway,
    this.minimalPriceOfWay,
    this.priceOfWay,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory RidesElement.fromMap(Map<String, dynamic> map) => RidesElement(
        id: map["id"],
        creatorId: map["creator_id"],
        automobilId: map["automobil_id"],
        fromCoordinates: map["from_coordinates"] == null
            ? null
            : GETCOORDINATES.fromMap(map["from_coordinates"]),
        toCoordinates: map["to_coordinates"] == null
            ? null
            : GETCOORDINATES.fromMap(map["to_coordinates"]),
        startTime: map["start_time"],
        kmofway: map["kmofway"],
        minimalPriceOfWay: map["minimal_price_of_way"],
        priceOfWay: map["price_of_way"],
        paymentMethod: map["payment_method"],
        status: map["status"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
      );

  factory RidesElement.fromJson(String str) =>
      RidesElement.fromMap(json.decode(str));

  final int? id;
  final int? creatorId;
  final int? automobilId;
  final GETCOORDINATES? fromCoordinates;
  final GETCOORDINATES? toCoordinates;
  final int? startTime;
  final String? kmofway;
  final String? minimalPriceOfWay;
  final String? priceOfWay;
  final String? paymentMethod;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Map<String, dynamic> toMap() => {
        "id": id,
        "creator_id": creatorId,
        "automobil_id": automobilId,
        "from_coordinates": fromCoordinates?.toMap(),
        "to_coordinates": toCoordinates?.toMap(),
        "start_time": startTime,
        "kmofway": kmofway,
        "minimal_price_of_way": minimalPriceOfWay,
        "price_of_way": priceOfWay,
        "payment_method": paymentMethod,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  String toJson() => json.encode(toMap());
}

class Automobil {
  const Automobil({
    this.id,
    this.userId,
    this.drivingLicence,
    this.idCard,
    this.technicalPassport,
    this.autoSerialNumber,
    this.selected,
    this.autoMarkId,
    this.autoModelId,
    this.autoColorId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
    this.automark,
    this.automodels,
    this.autocolors,
    this.images,
  });

  factory Automobil.fromMap(Map<String, dynamic> map) => Automobil(
        id: map["id"],
        userId: map["user_id"],
        drivingLicence: map["driving_licence"],
        idCard: map["id_card"],
        technicalPassport: map["technical_passport"],
        autoSerialNumber: map["auto_serial_number"],
        selected: map["selected"],
        autoMarkId: map["auto_mark_id"],
        autoModelId: map["auto_model_id"],
        autoColorId: map["auto_color_id"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
        user: map["user"] == null ? null : Users.fromMap(map["user"]),
        automark:
            map["automark"] == null ? null : Automark.fromMap(map["automark"]),
        automodels: map["automodels"] == null
            ? null
            : Automodels.fromMap(map["automodels"]),
        autocolors: map["autocolors"] == null
            ? null
            : Autocolors.fromMap(map["autocolors"]),
        images: map["images"] == null
            ? null
            : List<Images>.from(map["images"].map((e) => Images.fromMap(e))),
      );

  factory Automobil.fromJson(String str) => Automobil.fromMap(json.decode(str));

  final int? id;
  final int? userId;
  final String? drivingLicence;
  final String? idCard;
  final String? technicalPassport;
  final String? autoSerialNumber;
  final bool? selected;
  final int? autoMarkId;
  final int? autoModelId;
  final int? autoColorId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final Users? user;
  final Automark? automark;
  final Automodels? automodels;
  final Autocolors? autocolors;
  final List<Images>? images;

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "driving_licence": drivingLicence,
        "id_card": idCard,
        "technical_passport": technicalPassport,
        "auto_serial_number": autoSerialNumber,
        "selected": selected,
        "auto_mark_id": autoMarkId,
        "auto_model_id": autoModelId,
        "auto_color_id": autoColorId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "user": user?.toMap(),
        "automark": automark?.toMap(),
        "automodels": automodels?.toMap(),
        "autocolors": autocolors?.toMap(),
        "images": images?.map((e) => e?.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}

class Images {
  const Images({
    this.id,
    this.automobilId,
    this.image,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  factory Images.fromMap(Map<String, dynamic> map) => Images(
        id: map["id"],
        automobilId: map["automobil_id"],
        image: map["image"],
        order: map["order"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
      );

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  final int? id;
  final int? automobilId;
  final String? image;
  final int? order;
  final String? createdAt;
  final String? updatedAt;

  Map<String, dynamic> toMap() => {
        "id": id,
        "automobil_id": automobilId,
        "image": image,
        "order": order,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  String toJson() => json.encode(toMap());
}

class Autocolors {
  const Autocolors({
    this.id,
    this.name,
    this.slugs,
    this.hex,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Autocolors.fromMap(Map<String, dynamic> map) => Autocolors(
        id: map["id"],
        name: map["name"] == null ? null : Name.fromMap(map["name"]),
        slugs: map["slugs"] == null ? null : Slugs.fromMap(map["slugs"]),
        hex: map["hex"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
      );

  factory Autocolors.fromJson(String str) =>
      Autocolors.fromMap(json.decode(str));

  final int? id;
  final Name? name;
  final Slugs? slugs;
  final String? hex;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name?.toMap(),
        "slugs": slugs?.toMap(),
        "hex": hex,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  String toJson() => json.encode(toMap());
}

class Automodels {
  const Automodels({
    this.id,
    this.autoMarkId,
    this.icon,
    this.name,
    this.slugs,
    this.places,
    this.weight,
    this.liter,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Automodels.fromMap(Map<String, dynamic> map) => Automodels(
        id: map["id"],
        autoMarkId: map["auto_mark_id"],
        icon: map["icon"],
        name: map["name"] == null ? null : Name.fromMap(map["name"]),
        slugs: map["slugs"] == null ? null : Slugs.fromMap(map["slugs"]),
        places: map["places"],
        weight: map["weight"],
        liter: map["liter"],
        order: map["order"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
      );

  factory Automodels.fromJson(String str) =>
      Automodels.fromMap(json.decode(str));

  final int? id;
  final int? autoMarkId;
  final String? icon;
  final Name? name;
  final Slugs? slugs;
  final int? places;
  final String? weight;
  final String? liter;
  final int? order;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Map<String, dynamic> toMap() => {
        "id": id,
        "auto_mark_id": autoMarkId,
        "icon": icon,
        "name": name?.toMap(),
        "slugs": slugs?.toMap(),
        "places": places,
        "weight": weight,
        "liter": liter,
        "order": order,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  String toJson() => json.encode(toMap());
}

class Automark {
  const Automark({
    this.id,
    this.icon,
    this.name,
    this.slugs,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Automark.fromMap(Map<String, dynamic> map) => Automark(
        id: map["id"],
        icon: map["icon"],
        name: map["name"] == null ? null : Name.fromMap(map["name"]),
        slugs: map["slugs"] == null ? null : Slugs.fromMap(map["slugs"]),
        order: map["order"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
      );

  factory Automark.fromJson(String str) => Automark.fromMap(json.decode(str));

  final int? id;
  final String? icon;
  final Name? name;
  final Slugs? slugs;
  final int? order;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Map<String, dynamic> toMap() => {
        "id": id,
        "icon": icon,
        "name": name?.toMap(),
        "slugs": slugs?.toMap(),
        "order": order,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  String toJson() => json.encode(toMap());
}

class GETCOORDINATES {
  const GETCOORDINATES({this.latitude, this.longitude, this.address});

  factory GETCOORDINATES.fromMap(Map<String, dynamic> map) => GETCOORDINATES(
        latitude: map["latitude"],
        longitude: map["longitude"],
        address: map["address"],
      );

  factory GETCOORDINATES.fromJson(String str) =>
      GETCOORDINATES.fromMap(json.decode(str));

  final String? latitude;
  final String? longitude;
  final String? address;

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
      };

  String toJson() => json.encode(toMap());
}

