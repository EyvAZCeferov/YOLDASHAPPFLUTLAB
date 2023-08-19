import 'dart:convert';

class BalanceTypes {
  final String? type;
  final List<BalanceElement>? elements;

  BalanceTypes({
    this.type,
    this.elements,
  });

  factory BalanceTypes.fromMap(Map<String, dynamic> map) {
    return BalanceTypes(
      type: map['type'],
      elements: List<BalanceElement>.from(
          map['data'].map((x) => BalanceElement.fromMap(x))),
    );
  }
}

class BalanceElement {
  final int? id;
  final Name? name;
  final String? type;
  final int? price;
  final int? order;
  final int? days;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? deletedAt;

  BalanceElement({
    this.id,
    this.name,
    this.type,
    this.price,
    this.order,
    this.days,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory BalanceElement.fromMap(Map<String, dynamic> map) {
    return BalanceElement(
      id: map['id'],
      name: Name.fromMap(map['name']),
      type: map['type'],
      price: map['price'],
      order: map['order'],
      days: map['days'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: map['deleted_at'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "price": price,
        "order": order,
        "days": days,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class Name {
  final String azName;
  final String ruName;
  final String enName;
  final String trName;

  Name({
    required this.azName,
    required this.ruName,
    required this.enName,
    required this.trName,
  });

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      azName: map['az_name'],
      ruName: map['ru_name'],
      enName: map['en_name'],
      trName: map['tr_name'],
    );
  }
}
