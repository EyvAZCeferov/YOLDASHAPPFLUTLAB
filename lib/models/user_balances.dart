import 'dart:convert';

import 'package:yoldash/models/balance_types.dart';

class UserBalances {
  const UserBalances({
    this.id,
    this.userId,
    this.balanceTypeId,
    this.price,
    this.action,
    this.startsAt,
    this.endsAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.balancetype,
  });

  factory UserBalances.fromMap(Map<String, dynamic> map) => UserBalances(
        id: map['id'],
        userId: map['user_id'],
        balanceTypeId: map['balance_type_id'],
        price: map['price'],
        action: map['action'],
        startsAt: map['starts_at'],
        endsAt: map['ends_at'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        deletedAt: map['deleted_at'],
        balancetype: map['balancetype'] == null
            ? null
            : BalanceElement.fromMap(map['balancetype']),
      );

  factory UserBalances.fromJson(String str) =>
      UserBalances.fromMap(json.decode(str));

  final int? id;
  final int? userId;
  final int? balanceTypeId;
  final int? price;
  final String? action;
  final String? startsAt;
  final String? endsAt;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final BalanceElement? balancetype;

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'balance_type_id': balanceTypeId,
        'price': price,
        'action': action,
        'starts_at': startsAt,
        'ends_at': endsAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'balancetype': balancetype?.toMap(),
      };

  String toJson() => json.encode(toMap());

  UserBalances copyWith({
    int? id,
    int? userId,
    int? balanceTypeId,
    int? price,
    String? action,
    String? startsAt,
    String? endsAt,
    String? createdAt,
    String? updatedAt,
    dynamic? deletedAt,
    BalanceElement? balancetype,
  }) =>
      UserBalances(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        balanceTypeId: balanceTypeId ?? this.balanceTypeId,
        price: price ?? this.price,
        action: action ?? this.action,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        balancetype: balancetype ?? this.balancetype,
      );

  @override
  String toString() =>
      'UserBalances(id: $id, userId: $userId, balanceTypeId: $balanceTypeId, price: $price, action: $action, startsAt: $startsAt, endsAt: $endsAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, balancetype: $balancetype)';
}
