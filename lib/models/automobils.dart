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
    this.autoMarkId,
    this.autoModelId,
    this.autoColorId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.automark,
    this.automodels,
    this.autocolors,
    this.images,
  });

  factory Automobils.fromMap(Map<String, dynamic> map) => Automobils(
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

  factory Automobils.fromJson(String str) =>
      Automobils.fromMap(json.decode(str));

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
        "automark": automark?.toMap(),
        "automodels": automodels?.toMap(),
        "autocolors": autocolors?.toMap(),
        "images": images?.map((e) => e?.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());

  Automobils copyWith({
    int? id,
    int? userId,
    String? drivingLicence,
    String? idCard,
    String? technicalPassport,
    String? autoSerialNumber,
    bool? selected,
    int? autoMarkId,
    int? autoModelId,
    int? autoColorId,
    String? createdAt,
    String? updatedAt,
    dynamic? deletedAt,
    Automark? automark,
    Automodels? automodels,
    Autocolors? autocolors,
    List<Images>? images,
  }) =>
      Automobils(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        drivingLicence: drivingLicence ?? this.drivingLicence,
        idCard: idCard ?? this.idCard,
        technicalPassport: technicalPassport ?? this.technicalPassport,
        autoSerialNumber: autoSerialNumber ?? this.autoSerialNumber,
        selected: selected ?? this.selected,
        autoMarkId: autoMarkId ?? this.autoMarkId,
        autoModelId: autoModelId ?? this.autoModelId,
        autoColorId: autoColorId ?? this.autoColorId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        automark: automark ?? this.automark,
        automodels: automodels ?? this.automodels,
        autocolors: autocolors ?? this.autocolors,
        images: images ?? this.images,
      );

  @override
  String toString() =>
      "Automobils(id: $id, userId: $userId, drivingLicence: $drivingLicence, idCard: $idCard, technicalPassport: $technicalPassport, autoSerialNumber: $autoSerialNumber, selected: $selected, autoMarkId: $autoMarkId, autoModelId: $autoModelId, autoColorId: $autoColorId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, automark: $automark, automodels: $automodels, autocolors: $autocolors, images: $images)";
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

  Images copyWith({
    int? id,
    int? automobilId,
    String? image,
    int? order,
    String? createdAt,
    String? updatedAt,
  }) =>
      Images(
        id: id ?? this.id,
        automobilId: automobilId ?? this.automobilId,
        image: image ?? this.image,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  String toString() =>
      "Images(id: $id, automobilId: $automobilId, image: $image, order: $order, createdAt: $createdAt, updatedAt: $updatedAt)";
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

  Autocolors copyWith({
    int? id,
    Name? name,
    Slugs? slugs,
    String? hex,
    String? createdAt,
    String? updatedAt,
    dynamic? deletedAt,
  }) =>
      Autocolors(
        id: id ?? this.id,
        name: name ?? this.name,
        slugs: slugs ?? this.slugs,
        hex: hex ?? this.hex,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  @override
  String toString() =>
      "Autocolors(id: $id, name: $name, slugs: $slugs, hex: $hex, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)";
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

  Automodels copyWith({
    int? id,
    int? autoMarkId,
    String? icon,
    Name? name,
    Slugs? slugs,
    int? places,
    String? weight,
    String? liter,
    int? order,
    String? createdAt,
    String? updatedAt,
    dynamic? deletedAt,
  }) =>
      Automodels(
        id: id ?? this.id,
        autoMarkId: autoMarkId ?? this.autoMarkId,
        icon: icon ?? this.icon,
        name: name ?? this.name,
        slugs: slugs ?? this.slugs,
        places: places ?? this.places,
        weight: weight ?? this.weight,
        liter: liter ?? this.liter,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  @override
  String toString() =>
      "Automodels(id: $id, autoMarkId: $autoMarkId, icon: $icon, name: $name, slugs: $slugs, places: $places, weight: $weight, liter: $liter, order: $order, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)";
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

  Automark copyWith({
    int? id,
    String? icon,
    Name? name,
    Slugs? slugs,
    int? order,
    String? createdAt,
    String? updatedAt,
    dynamic? deletedAt,
  }) =>
      Automark(
        id: id ?? this.id,
        icon: icon ?? this.icon,
        name: name ?? this.name,
        slugs: slugs ?? this.slugs,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  @override
  String toString() =>
      "Automark(id: $id, icon: $icon, name: $name, slugs: $slugs, order: $order, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)";
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

  Slugs copyWith({
    String? azSlug,
    String? ruSlug,
    String? enSlug,
    String? trSlug,
  }) =>
      Slugs(
        azSlug: azSlug ?? this.azSlug,
        ruSlug: ruSlug ?? this.ruSlug,
        enSlug: enSlug ?? this.enSlug,
        trSlug: trSlug ?? this.trSlug,
      );

  @override
  String toString() =>
      "Slugs(azSlug: $azSlug, ruSlug: $ruSlug, enSlug: $enSlug, trSlug: $trSlug)";
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

  Name copyWith({
    String? azName,
    String? ruName,
    String? enName,
    String? trName,
  }) =>
      Name(
        azName: azName ?? this.azName,
        ruName: ruName ?? this.ruName,
        enName: enName ?? this.enName,
        trName: trName ?? this.trName,
      );

  @override
  String toString() =>
      "Name(azName: $azName, ruName: $ruName, enName: $enName, trName: $trName)";
}
