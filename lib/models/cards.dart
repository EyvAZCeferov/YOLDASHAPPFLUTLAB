import "dart:convert";

class Cards {
  const Cards({
      this.id,
      this.userId,
      this.cardnumber,
      this.cardholdername,
      this.cardtype,
      this.validdate,
      this.cvv,
      this.selected,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
  });
  
  factory Cards.fromMap(Map<String, dynamic> map) => Cards(
      id: map["id"],
      userId: map["user_id"],
      cardnumber: map["cardnumber"],
      cardholdername: map["cardholdername"],
      cardtype: map["cardtype"],
      validdate: map["validdate"],
      cvv: map["cvv"],
      selected: map["selected"],
      verified: map["verified"],
      createdAt: map["created_at"],
      updatedAt: map["updated_at"],
      deletedAt: map["deleted_at"],
  );
  
  factory Cards.fromJson(String str) => Cards.fromMap(json.decode(str));
  
  final int? id;
  final int? userId;
  final String? cardnumber;
  final String? cardholdername;
  final String? cardtype;
  final String? validdate;
  final String? cvv;
  final bool? selected;
  final bool? verified;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  
  Map<String, dynamic> toMap() => {
      "id": id,
      "user_id": userId,
      "cardnumber": cardnumber,
      "cardholdername": cardholdername,
      "cardtype": cardtype,
      "validdate": validdate,
      "cvv": cvv,
      "selected": selected,
      "verified": verified,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "deleted_at": deletedAt,
  };
  
}

