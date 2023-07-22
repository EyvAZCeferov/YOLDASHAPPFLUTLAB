import "dart:convert";
import "package:flutter/widgets.dart";

class Settings {
  const Settings({
      this.id,
      this.name,
      this.description,
      this.address,
      this.socialMedia,
      this.urls,
      this.keys,
      this.lightLogo,
      this.darkLogo,
      this.colors,
      this.createdAt,
      this.updatedAt,
  });
  
  factory Settings.fromMap(Map<String, dynamic> map) => Settings(
      id: map["id"],
      name: map["name"] == null ? null : Name.fromMap(map["name"]),
      description: map["description"] == null ? null : Description.fromMap(map["description"]),
      address: map["address"] == null ? null : Address.fromMap(map["address"]),
      socialMedia: map["social_media"] == null ? null : SocialMedia.fromMap(map["social_media"]),
      urls: map["urls"] == null ? null : Urls.fromMap(map["urls"]),
      keys: map["keys"],
      lightLogo: map["light_logo"],
      darkLogo: map["dark_logo"],
      colors: map["colors"] == null ? null : Colors.fromMap(map["colors"]),
      createdAt: map["created_at"],
      updatedAt: map["updated_at"],
  );
  
  factory Settings.fromJson(String str) => Settings.fromMap(json.decode(str));
  
  final int? id;
  final Name? name;
  final Description? description;
  final Address? address;
  final SocialMedia? socialMedia;
  final Urls? urls;
  final dynamic keys;
  final String? lightLogo;
  final String? darkLogo;
  final Colors? colors;
  final String? createdAt;
  final String? updatedAt;
  
  @override
  int get hashCode => hashValues(id, name, description, address, socialMedia, urls, keys, lightLogo, darkLogo, colors, createdAt, updatedAt);
  
  Map<String, dynamic> toMap() => {
      "id": id,
      "name": name?.toMap(),
      "description": description?.toMap(),
      "address": address?.toMap(),
      "social_media": socialMedia?.toMap(),
      "urls": urls?.toMap(),
      "keys": keys,
      "light_logo": lightLogo,
      "dark_logo": darkLogo,
      "colors": colors?.toMap(),
      "created_at": createdAt,
      "updated_at": updatedAt,
  };
  
  String toJson() => json.encode(toMap());
  
  Settings copyWith({
      int? id,
      Name? name,
      Description? description,
      Address? address,
      SocialMedia? socialMedia,
      Urls? urls,
      dynamic? keys,
      String? lightLogo,
      String? darkLogo,
      Colors? colors,
      String? createdAt,
      String? updatedAt,
  }) => Settings(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      socialMedia: socialMedia ?? this.socialMedia,
      urls: urls ?? this.urls,
      keys: keys ?? this.keys,
      lightLogo: lightLogo ?? this.lightLogo,
      darkLogo: darkLogo ?? this.darkLogo,
      colors: colors ?? this.colors,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
  );
  
  @override
  String toString() => "Settings(id: $id, name: $name, description: $description, address: $address, socialMedia: $socialMedia, urls: $urls, keys: $keys, lightLogo: $lightLogo, darkLogo: $darkLogo, colors: $colors, createdAt: $createdAt, updatedAt: $updatedAt)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Settings &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.address == address &&
        other.socialMedia == socialMedia &&
        other.urls == urls &&
        other.keys == keys &&
        other.lightLogo == lightLogo &&
        other.darkLogo == darkLogo &&
        other.colors == colors &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}

class Colors {
  const Colors({
      this.body,
      this.primary,
      this.secondary,
  });
  
  factory Colors.fromMap(Map<String, dynamic> map) => Colors(
      body: map["body"],
      primary: map["primary"],
      secondary: map["secondary"],
  );
  
  factory Colors.fromJson(String str) => Colors.fromMap(json.decode(str));
  
  final String? body;
  final String? primary;
  final String? secondary;
  
  @override
  int get hashCode => hashValues(body, primary, secondary);
  
  Map<String, dynamic> toMap() => {
      "body": body,
      "primary": primary,
      "secondary": secondary,
  };
  
  String toJson() => json.encode(toMap());
  
  Colors copyWith({
      String? body,
      String? primary,
      String? secondary,
  }) => Colors(
      body: body ?? this.body,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
  );
  
  @override
  String toString() => "Colors(body: $body, primary: $primary, secondary: $secondary)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Colors &&
        other.body == body &&
        other.primary == primary &&
        other.secondary == secondary;
  }
}

class Urls {
  const Urls({
      this.apiUrl,
      this.siteUrl,
      this.adminUrl,
  });
  
  factory Urls.fromMap(Map<String, dynamic> map) => Urls(
      apiUrl: map["api_url"],
      siteUrl: map["site_url"],
      adminUrl: map["admin_url"],
  );
  
  factory Urls.fromJson(String str) => Urls.fromMap(json.decode(str));
  
  final String? apiUrl;
  final String? siteUrl;
  final String? adminUrl;
  
  @override
  int get hashCode => hashValues(apiUrl, siteUrl, adminUrl);
  
  Map<String, dynamic> toMap() => {
      "api_url": apiUrl,
      "site_url": siteUrl,
      "admin_url": adminUrl,
  };
  
  String toJson() => json.encode(toMap());
  
  Urls copyWith({
      String? apiUrl,
      String? siteUrl,
      String? adminUrl,
  }) => Urls(
      apiUrl: apiUrl ?? this.apiUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      adminUrl: adminUrl ?? this.adminUrl,
  );
  
  @override
  String toString() => "Urls(apiUrl: $apiUrl, siteUrl: $siteUrl, adminUrl: $adminUrl)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Urls &&
        other.apiUrl == apiUrl &&
        other.siteUrl == siteUrl &&
        other.adminUrl == adminUrl;
  }
}

class SocialMedia {
  const SocialMedia({
      this.email,
      this.tiktok,
      this.whatsapp,
      this.gmapsUrl,
      this.homePhone,
      this.youtubeUrl,
      this.facebookUrl,
      this.mobilePhone,
      this.instagramUrl,
  });
  
  factory SocialMedia.fromMap(Map<String, dynamic> map) => SocialMedia(
      email: map["email"],
      tiktok: map["tiktok"],
      whatsapp: map["whatsapp"],
      gmapsUrl: map["gmaps_url"],
      homePhone: map["home_phone"],
      youtubeUrl: map["youtube_url"],
      facebookUrl: map["facebook_url"],
      mobilePhone: map["mobile_phone"],
      instagramUrl: map["instagram_url"],
  );
  
  factory SocialMedia.fromJson(String str) => SocialMedia.fromMap(json.decode(str));
  
  final String? email;
  final String? tiktok;
  final String? whatsapp;
  final String? gmapsUrl;
  final String? homePhone;
  final String? youtubeUrl;
  final String? facebookUrl;
  final String? mobilePhone;
  final String? instagramUrl;
  
  @override
  int get hashCode => hashValues(email, tiktok, whatsapp, gmapsUrl, homePhone, youtubeUrl, facebookUrl, mobilePhone, instagramUrl);
  
  Map<String, dynamic> toMap() => {
      "email": email,
      "tiktok": tiktok,
      "whatsapp": whatsapp,
      "gmaps_url": gmapsUrl,
      "home_phone": homePhone,
      "youtube_url": youtubeUrl,
      "facebook_url": facebookUrl,
      "mobile_phone": mobilePhone,
      "instagram_url": instagramUrl,
  };
  
  String toJson() => json.encode(toMap());
  
  SocialMedia copyWith({
      String? email,
      String? tiktok,
      String? whatsapp,
      String? gmapsUrl,
      String? homePhone,
      String? youtubeUrl,
      String? facebookUrl,
      String? mobilePhone,
      String? instagramUrl,
  }) => SocialMedia(
      email: email ?? this.email,
      tiktok: tiktok ?? this.tiktok,
      whatsapp: whatsapp ?? this.whatsapp,
      gmapsUrl: gmapsUrl ?? this.gmapsUrl,
      homePhone: homePhone ?? this.homePhone,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      instagramUrl: instagramUrl ?? this.instagramUrl,
  );
  
  @override
  String toString() => "SocialMedia(email: $email, tiktok: $tiktok, whatsapp: $whatsapp, gmapsUrl: $gmapsUrl, homePhone: $homePhone, youtubeUrl: $youtubeUrl, facebookUrl: $facebookUrl, mobilePhone: $mobilePhone, instagramUrl: $instagramUrl)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SocialMedia &&
        other.email == email &&
        other.tiktok == tiktok &&
        other.whatsapp == whatsapp &&
        other.gmapsUrl == gmapsUrl &&
        other.homePhone == homePhone &&
        other.youtubeUrl == youtubeUrl &&
        other.facebookUrl == facebookUrl &&
        other.mobilePhone == mobilePhone &&
        other.instagramUrl == instagramUrl;
  }
}

class Address {
  const Address({
      this.azAddress,
      this.enAddress,
      this.ruAddress,
      this.trAddress,
  });
  
  factory Address.fromMap(Map<String, dynamic> map) => Address(
      azAddress: map["az_address"],
      enAddress: map["en_address"],
      ruAddress: map["ru_address"],
      trAddress: map["tr_address"],
  );
  
  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));
  
  final String? azAddress;
  final String? enAddress;
  final String? ruAddress;
  final String? trAddress;
  
  @override
  int get hashCode => hashValues(azAddress, enAddress, ruAddress, trAddress);
  
  Map<String, dynamic> toMap() => {
      "az_address": azAddress,
      "en_address": enAddress,
      "ru_address": ruAddress,
      "tr_address": trAddress,
  };
  
  String toJson() => json.encode(toMap());
  
  Address copyWith({
      String? azAddress,
      String? enAddress,
      String? ruAddress,
      String? trAddress,
  }) => Address(
      azAddress: azAddress ?? this.azAddress,
      enAddress: enAddress ?? this.enAddress,
      ruAddress: ruAddress ?? this.ruAddress,
      trAddress: trAddress ?? this.trAddress,
  );
  
  @override
  String toString() => "Address(azAddress: $azAddress, enAddress: $enAddress, ruAddress: $ruAddress, trAddress: $trAddress)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Address &&
        other.azAddress == azAddress &&
        other.enAddress == enAddress &&
        other.ruAddress == ruAddress &&
        other.trAddress == trAddress;
  }
}

class Description {
  const Description({
      this.azDescription,
      this.enDescription,
      this.ruDescription,
      this.trDescription,
  });
  
  factory Description.fromMap(Map<String, dynamic> map) => Description(
      azDescription: map["az_description"],
      enDescription: map["en_description"],
      ruDescription: map["ru_description"],
      trDescription: map["tr_description"],
  );
  
  factory Description.fromJson(String str) => Description.fromMap(json.decode(str));
  
  final String? azDescription;
  final String? enDescription;
  final String? ruDescription;
  final String? trDescription;
  
  @override
  int get hashCode => hashValues(azDescription, enDescription, ruDescription, trDescription);
  
  Map<String, dynamic> toMap() => {
      "az_description": azDescription,
      "en_description": enDescription,
      "ru_description": ruDescription,
      "tr_description": trDescription,
  };
  
  String toJson() => json.encode(toMap());
  
  Description copyWith({
      String? azDescription,
      String? enDescription,
      String? ruDescription,
      String? trDescription,
  }) => Description(
      azDescription: azDescription ?? this.azDescription,
      enDescription: enDescription ?? this.enDescription,
      ruDescription: ruDescription ?? this.ruDescription,
      trDescription: trDescription ?? this.trDescription,
  );
  
  @override
  String toString() => "Description(azDescription: $azDescription, enDescription: $enDescription, ruDescription: $ruDescription, trDescription: $trDescription)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Description &&
        other.azDescription == azDescription &&
        other.enDescription == enDescription &&
        other.ruDescription == ruDescription &&
        other.trDescription == trDescription;
  }
}

class Name {
  const Name({
      this.azName,
      this.enName,
      this.ruName,
      this.trName,
  });
  
  factory Name.fromMap(Map<String, dynamic> map) => Name(
      azName: map["az_name"],
      enName: map["en_name"],
      ruName: map["ru_name"],
      trName: map["tr_name"],
  );
  
  factory Name.fromJson(String str) => Name.fromMap(json.decode(str));
  
  final String? azName;
  final String? enName;
  final String? ruName;
  final String? trName;
  
  @override
  int get hashCode => hashValues(azName, enName, ruName, trName);
  
  Map<String, dynamic> toMap() => {
      "az_name": azName,
      "en_name": enName,
      "ru_name": ruName,
      "tr_name": trName,
  };
  
  String toJson() => json.encode(toMap());
  
  Name copyWith({
      String? azName,
      String? enName,
      String? ruName,
      String? trName,
  }) => Name(
      azName: azName ?? this.azName,
      enName: enName ?? this.enName,
      ruName: ruName ?? this.ruName,
      trName: trName ?? this.trName,
  );
  
  @override
  String toString() => "Name(azName: $azName, enName: $enName, ruName: $ruName, trName: $trName)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Name &&
        other.azName == azName &&
        other.enName == enName &&
        other.ruName == ruName &&
        other.trName == trName;
  }
}

