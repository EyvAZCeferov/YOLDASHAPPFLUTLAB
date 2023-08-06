import "dart:convert";

class MessageGroups {
  const MessageGroups({
    this.id,
    this.receiverId,
    this.senderId,
    this.messagegroupCreatedAt,
    this.count,
    this.receiverName,
    this.senderName,
    this.receiverImage,
    this.senderImage,
    this.messages,
  });

  factory MessageGroups.fromMap(Map<String, dynamic> map) => MessageGroups(
        id: map["id"],
        receiverId: map["receiver_id"],
        senderId: map["sender_id"],
        messagegroupCreatedAt: map["messagegroup_created_at"],
        count: map["count"],
        receiverName: map["receiver_name"],
        senderName: map["sender_name"],
        receiverImage: map["receiver_image"],
        senderImage: map["sender_image"],
        messages: map["messages"] == null
            ? null
            : List<Messages>.from(
                map["messages"].map((e) => Messages.fromMap(e))),
      );

  factory MessageGroups.fromJson(Map<String, dynamic> map) {
    return MessageGroups(
      id: map["id"],
      receiverId: map["receiver_id"],
      senderId: map["sender_id"],
      messagegroupCreatedAt: map["messagegroup_created_at"],
      count: map["count"],
      receiverName: map["receiver_name"],
      senderName: map["sender_name"],
      receiverImage: map["receiver_image"],
      senderImage: map["sender_image"],
      messages: map["messages"] != null
          ? List<Messages>.from(
              map["messages"]
                  .map((messageData) => Messages.fromMap(messageData)),
            )
          : null,
    );
  }

  final int? id;
  final int? receiverId;
  final int? senderId;
  final String? messagegroupCreatedAt;
  final int? count;
  final String? receiverName;
  final String? senderName;
  final dynamic receiverImage;
  final dynamic senderImage;
  final List<Messages>? messages;

  Map<String, dynamic> toMap() => {
        "id": id,
        "receiver_id": receiverId,
        "sender_id": senderId,
        "messagegroup_created_at": messagegroupCreatedAt,
        "count": count,
        "receiver_name": receiverName,
        "sender_name": senderName,
        "receiver_image": receiverImage,
        "sender_image": senderImage,
        "messages": messages?.map((e) => e?.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());

  MessageGroups copyWith({
    int? id,
    int? receiverId,
    int? senderId,
    String? messagegroupCreatedAt,
    int? count,
    String? receiverName,
    String? senderName,
    dynamic? receiverImage,
    dynamic? senderImage,
    List<Messages>? messages,
  }) =>
      MessageGroups(
        id: id ?? this.id,
        receiverId: receiverId ?? this.receiverId,
        senderId: senderId ?? this.senderId,
        messagegroupCreatedAt:
            messagegroupCreatedAt ?? this.messagegroupCreatedAt,
        count: count ?? this.count,
        receiverName: receiverName ?? this.receiverName,
        senderName: senderName ?? this.senderName,
        receiverImage: receiverImage ?? this.receiverImage,
        senderImage: senderImage ?? this.senderImage,
        messages: messages ?? this.messages,
      );

  @override
  String toString() =>
      "MessageGroups(id: $id, receiverId: $receiverId, senderId: $senderId, messagegroupCreatedAt: $messagegroupCreatedAt, count: $count, receiverName: $receiverName, senderName: $senderName, receiverImage: $receiverImage, senderImage: $senderImage, messages: $messages)";
}

class Messages {
  const Messages({
    this.messageGroupId,
    this.message,
    this.userId,
    this.messageelementtype,
    this.status,
  });

  factory Messages.fromMap(Map<String, dynamic> map) => Messages(
        messageGroupId: map["message_group_id"],
        message: map["message"],
        userId: map["user_id"],
        messageelementtype: map["messageelementtype"],
        status: map["status"],
      );

  factory Messages.fromJson(Map<String, dynamic> map) => Messages(
        messageGroupId: map["message_group_id"],
        message: map["message"],
        userId: map["user_id"],
        messageelementtype: map["messageelementtype"],
        status: map["status"],
      );

  final int? messageGroupId;
  final String? message;
  final int? userId;
  final String? messageelementtype;
  final bool? status;

  Map<String, dynamic> toMap() => {
        "message_group_id": messageGroupId,
        "message": message,
        "user_id": userId,
        "messageelementtype": messageelementtype,
        "status": status,
      };

  String toJson() => json.encode(toMap());

  Messages copyWith({
    int? messageGroupId,
    String? message,
    int? userId,
    String? messageelementtype,
    bool? status,
  }) =>
      Messages(
        messageGroupId: messageGroupId ?? this.messageGroupId,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        messageelementtype: messageelementtype ?? this.messageelementtype,
        status: status ?? this.status,
      );

  @override
  String toString() =>
      "Messages(messageGroupId: $messageGroupId, message: $message, userId: $userId, messageelementtype: $messageelementtype, status: $status)";
}
