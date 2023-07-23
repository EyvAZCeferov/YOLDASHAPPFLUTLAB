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
      this.primary,
      this.secondary,
      this.body,
  });
  
  factory Colors.fromMap(Map<String, dynamic> map) => Colors(
      primary: map["primary"],
      secondary: map["secondary"],
      body: map["body"],
  );
  
  factory Colors.fromJson(String str) => Colors.fromMap(json.decode(str));
  
  final String? primary;
  final String? secondary;
  final String? body;
  
  @override
  int get hashCode => hashValues(primary, secondary, body);
  
  Map<String, dynamic> toMap() => {
      "primary": primary,
      "secondary": secondary,
      "body": body,
  };
  
  String toJson() => json.encode(toMap());
  
  Colors copyWith({
      String? primary,
      String? secondary,
      String? body,
  }) => Colors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      body: body ?? this.body,
  );
  
  @override
  String toString() => "Colors(primary: $primary, secondary: $secondary, body: $body)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Colors &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.body == body;
  }
}

class Urls {
  const Urls({
      this.adminUrl,
      this.apiUrl,
      this.siteUrl,
  });
  
  factory Urls.fromMap(Map<String, dynamic> map) => Urls(
      adminUrl: map["admin_url"],
      apiUrl: map["api_url"],
      siteUrl: map["site_url"],
  );
  
  factory Urls.fromJson(String str) => Urls.fromMap(json.decode(str));
  
  final String? adminUrl;
  final String? apiUrl;
  final String? siteUrl;
  
  @override
  int get hashCode => hashValues(adminUrl, apiUrl, siteUrl);
  
  Map<String, dynamic> toMap() => {
      "admin_url": adminUrl,
      "api_url": apiUrl,
      "site_url": siteUrl,
  };
  
  String toJson() => json.encode(toMap());
  
  Urls copyWith({
      String? adminUrl,
      String? apiUrl,
      String? siteUrl,
  }) => Urls(
      adminUrl: adminUrl ?? this.adminUrl,
      apiUrl: apiUrl ?? this.apiUrl,
      siteUrl: siteUrl ?? this.siteUrl,
  );
  
  @override
  String toString() => "Urls(adminUrl: $adminUrl, apiUrl: $apiUrl, siteUrl: $siteUrl)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Urls &&
        other.adminUrl == adminUrl &&
        other.apiUrl == apiUrl &&
        other.siteUrl == siteUrl;
  }
}

class SocialMedia {
  const SocialMedia({
      this.facebookUrl,
      this.instagramUrl,
      this.mobilePhone,
      this.homePhone,
      this.whatsapp,
      this.email,
      this.gmapsUrl,
      this.youtubeUrl,
      this.tiktok,
  });
  
  factory SocialMedia.fromMap(Map<String, dynamic> map) => SocialMedia(
      facebookUrl: map["facebook_url"],
      instagramUrl: map["instagram_url"],
      mobilePhone: map["mobile_phone"],
      homePhone: map["home_phone"],
      whatsapp: map["whatsapp"],
      email: map["email"],
      gmapsUrl: map["gmaps_url"],
      youtubeUrl: map["youtube_url"],
      tiktok: map["tiktok"],
  );
  
  factory SocialMedia.fromJson(String str) => SocialMedia.fromMap(json.decode(str));
  
  final String? facebookUrl;
  final String? instagramUrl;
  final String? mobilePhone;
  final String? homePhone;
  final String? whatsapp;
  final String? email;
  final String? gmapsUrl;
  final String? youtubeUrl;
  final String? tiktok;
  
  @override
  int get hashCode => hashValues(facebookUrl, instagramUrl, mobilePhone, homePhone, whatsapp, email, gmapsUrl, youtubeUrl, tiktok);
  
  Map<String, dynamic> toMap() => {
      "facebook_url": facebookUrl,
      "instagram_url": instagramUrl,
      "mobile_phone": mobilePhone,
      "home_phone": homePhone,
      "whatsapp": whatsapp,
      "email": email,
      "gmaps_url": gmapsUrl,
      "youtube_url": youtubeUrl,
      "tiktok": tiktok,
  };
  
  String toJson() => json.encode(toMap());
  
  SocialMedia copyWith({
      String? facebookUrl,
      String? instagramUrl,
      String? mobilePhone,
      String? homePhone,
      String? whatsapp,
      String? email,
      String? gmapsUrl,
      String? youtubeUrl,
      String? tiktok,
  }) => SocialMedia(
      facebookUrl: facebookUrl ?? this.facebookUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      homePhone: homePhone ?? this.homePhone,
      whatsapp: whatsapp ?? this.whatsapp,
      email: email ?? this.email,
      gmapsUrl: gmapsUrl ?? this.gmapsUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      tiktok: tiktok ?? this.tiktok,
  );
  
  @override
  String toString() => "SocialMedia(facebookUrl: $facebookUrl, instagramUrl: $instagramUrl, mobilePhone: $mobilePhone, homePhone: $homePhone, whatsapp: $whatsapp, email: $email, gmapsUrl: $gmapsUrl, youtubeUrl: $youtubeUrl, tiktok: $tiktok)";
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SocialMedia &&
        other.facebookUrl == facebookUrl &&
        other.instagramUrl == instagramUrl &&
        other.mobilePhone == mobilePhone &&
        other.homePhone == homePhone &&
        other.whatsapp == whatsapp &&
        other.email == email &&
        other.gmapsUrl == gmapsUrl &&
        other.youtubeUrl == youtubeUrl &&
        other.tiktok == tiktok;
  }
}

class Address {
  const Address({
      this.azAddress,
      this.ruAddress,
      this.enAddress,
      this.trAddress,
  });
  
  factory Address.fromMap(Map<String, dynamic> map) => Address(
      azAddress: map["az_address"],
      ruAddress: map["ru_address"],
      enAddress: map["en_address"],
      trAddress: map["tr_address"],
  );
  
  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));
  
  final String? azAddress;
  final String? ruAddress;
  final String? enAddress;
  final String? trAddress;
  
  @override
  int get hashCode => hashValues(azAddress, ruAddress, enAddress, trAddress);
  
  Map<String, dynamic> toMap() => {
      "az_address": azAddress,
      "ru_address": ruAddress,
      "en_address": enAddress,
      "tr_address": trAddress,
  };
  
  String toJson() => json.encode(toMap());
  
  Address copyWith({
      String? azAddress,
      String? ruAddress,
      String? enAddress,
      String? trAddress,
  }) => Address(
      azAddress: azAddress ?? this.azAddress,
      ruAddress: ruAddress ?? this.ruAddress,
      enAddress: enAddress ?? this.enAddress,
      trAddress: trAddress ?? this.trAddress,
  );
  
  @override
  String toString() => "Address(azAddress: $azAddress, ruAddress: $ruAddress, enAddress: $enAddress, trAddress: $trAddress)";
  
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
        other.ruAddress == ruAddress &&
        other.enAddress == enAddress &&
        other.trAddress == trAddress;
  }
}

class Description {
  const Description({
      this.azDescription,
      this.ruDescription,
      this.enDescription,
      this.trDescription,
  });
  
  factory Description.fromMap(Map<String, dynamic> map) => Description(
      azDescription: map["az_description"],
      ruDescription: map["ru_description"],
      enDescription: map["en_description"],
      trDescription: map["tr_description"],
  );
  
  factory Description.fromJson(String str) => Description.fromMap(json.decode(str));
  
  final String? azDescription;
  final String? ruDescription;
  final String? enDescription;
  final String? trDescription;
  
  @override
  int get hashCode => hashValues(azDescription, ruDescription, enDescription, trDescription);
  
  Map<String, dynamic> toMap() => {
      "az_description": azDescription,
      "ru_description": ruDescription,
      "en_description": enDescription,
      "tr_description": trDescription,
  };
  
  String toJson() => json.encode(toMap());
  
  Description copyWith({
      String? azDescription,
      String? ruDescription,
      String? enDescription,
      String? trDescription,
  }) => Description(
      azDescription: azDescription ?? this.azDescription,
      ruDescription: ruDescription ?? this.ruDescription,
      enDescription: enDescription ?? this.enDescription,
      trDescription: trDescription ?? this.trDescription,
  );
  
  @override
  String toString() => "Description(azDescription: $azDescription, ruDescription: $ruDescription, enDescription: $enDescription, trDescription: $trDescription)";
  
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
        other.ruDescription == ruDescription &&
        other.enDescription == enDescription &&
        other.trDescription == trDescription;
  }
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
  
  @override
  int get hashCode => hashValues(azName, ruName, enName, trName);
  
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
  }) => Name(
      azName: azName ?? this.azName,
      ruName: ruName ?? this.ruName,
      enName: enName ?? this.enName,
      trName: trName ?? this.trName,
  );
  
  @override
  String toString() => "Name(azName: $azName, ruName: $ruName, enName: $enName, trName: $trName)";
  
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
        other.ruName == ruName &&
        other.enName == enName &&
        other.trName == trName;
  }
}

