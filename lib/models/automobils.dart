import "dart:convert";

class Automobils {
  const Automobils({
    this.id,
    this.userId,
    this.drivingLicence,
    this.idCard,
    this.technicalPassport,
    this.autoSerialNumber,
    this.selected,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.autotype,
    this.autoTypeId,
    this.images,
    this.marka,
    this.model,
    this.color,
  });

  factory Automobils.fromMap(Map<String, dynamic> map) => Automobils(
        id: map["id"],
        userId: map["user_id"],
        drivingLicence: map["driving_licence"],
        idCard: map["id_card"],
        technicalPassport: map["technical_passport"],
        autoSerialNumber: map["auto_serial_number"],
        selected: map["selected"],
        verified: map["verified"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
        marka: map["marka"],
        model: map["model"],
        color: map["color"],
        autoTypeId: map["auto_type_id"],
        autotype:
            map["autotype"] == null ? null : AutoType.fromMap(map["autotype"]),
        images: map["images"] == null
            ? null
            : List<Images>.from(map["images"].map((e) => Images.fromMap(e))),
      );

  factory Automobils.fromJson(String str) =>
      Automobils.fromMap(json.decode(str));

  final int? id;
  final int? userId;
  final String? drivingLicence;
  final String? idCard;
  final String? technicalPassport;
  final String? autoSerialNumber;
  final String? marka;
  final String? model;
  final String? color;
  final int? autoTypeId;
  final bool? selected;
  final bool? verified;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final AutoType? autotype;
  final List<Images>? images;

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "driving_licence": drivingLicence,
        "id_card": idCard,
        "technical_passport": technicalPassport,
        "auto_serial_number": autoSerialNumber,
        "selected": selected,
        "verified": verified,
        "marka": marka,
        "model": model,
        "color": color,
        "auto_type_id": autoTypeId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "autotype": autotype?.toMap(),
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

class AutoType {
  const AutoType(
      {this.id,
      this.icon,
      this.name,
      this.order_number,
      this.places,
      this.weight_kg,
      this.weight_liter,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.placesMark});

  factory AutoType.fromMap(Map<String, dynamic> map) => AutoType(
      id: map["id"],
      icon: map['icon'],
      name: map["name"] == null ? null : Name.fromMap(map["name"]),
      order_number: map['order_number'],
      places: map['places'],
      weight_kg: map['weight_kg'],
      weight_liter: map['weight_liter'],
      status: map['status'],
      createdAt: map["created_at"],
      updatedAt: map["updated_at"],
      deletedAt: map["deleted_at"],
      placesMark: map["places_mark"] == null
          ? null
          : List<PlacesMark>.from(
              map['places_mark'].map((e) => PlacesMark.fromMap(e))));

  factory AutoType.fromJson(String str) => AutoType.fromMap(json.decode(str));

  final int? id;
  final String? icon;
  final Name? name;
  final int? order_number;
  final int? places;
  final int? weight_kg;
  final int? weight_liter;
  final bool? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final List<PlacesMark>? placesMark;

  Map<String, dynamic> toMap() => {
        "id": id,
        "icon": icon,
        "name": name?.toMap(),
        "order_number": order_number,
        "places": places,
        "weight_kg": weight_kg,
        "weight_liter": weight_liter,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "placesMark": placesMark?.map((e) => e?.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}

class PlacesMark {
  const PlacesMark({
    this.id,
    this.autoTypeId,
    this.name,
    this.slugs,
    this.type,
    this.row,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PlacesMark.fromMap(Map<String, dynamic> map) => PlacesMark(
        id: map["id"],
        autoTypeId: map["auto_type_id"],
        name: map["name"] == null ? null : Name.fromMap(map["name"]),
        slugs: map["slugs"] == null ? null : Slugs.fromMap(map["slugs"]),
        type: map["type"],
        row: map["row"],
        position: map["position"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
        deletedAt: map["deleted_at"],
      );

  factory PlacesMark.fromJson(String str) =>
      PlacesMark.fromMap(json.decode(str));

  final int? id;
  final int? autoTypeId;
  final Name? name;
  final Slugs? slugs;
  final String? type;
  final int? row;
  final int? position;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  Map<String, dynamic> toMap() => {
        "id": id,
        "auto_type_id": autoTypeId,
        "name": name?.toMap(),
        "slugs": slugs?.toMap(),
        "type": type,
        "row": row,
        "position": position,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  String toJson() => json.encode(toMap());
}

class Slugs {
  const Slugs({
    this.azSlug,
    this.ruSlug,
    this.enSlug,
    this.trSlug,
  });

  factory Slugs.fromMap(Map<String, dynamic> map) => Slugs(
        azSlug: map["az_slug"],
        ruSlug: map["ru_slug"],
        enSlug: map["en_slug"],
        trSlug: map["tr_slug"],
      );

  factory Slugs.fromJson(String str) => Slugs.fromMap(json.decode(str));

  final String? azSlug;
  final String? ruSlug;
  final String? enSlug;
  final String? trSlug;

  Map<String, dynamic> toMap() => {
        "az_slug": azSlug,
        "ru_slug": ruSlug,
        "en_slug": enSlug,
        "tr_slug": trSlug,
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
        azName: map["az_name"],
        ruName: map["ru_name"],
        enName: map["en_name"],
        trName: map["tr_name"],
      );

  factory Name.fromJson(String str) => Name.fromMap(json.decode(str));

  final String? azName;
  final String? ruName;
  final String? enName;
  final String? trName;

  Map<String, dynamic> toMap() => {
        "az_name": azName,
        "ru_name": ruName,
        "en_name": enName,
        "tr_name": trName,
      };

  String toJson() => json.encode(toMap());
}
