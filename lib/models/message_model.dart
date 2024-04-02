import 'package:cloud_firestore/cloud_firestore.dart';

const kMessageTimestamp = 'timestamp';
const kMessageSenderId = 'senderId';
const kMessageText = 'text';
const kMessageSenderName = 'senderName';

class MessageModel {
  final DateTime time;
  final String senderUid;
  final String text;
  final String sender;

  MessageModel({
    required this.time,
    required this.senderUid,
    required this.text,
    required this.sender,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : time = (json[kMessageTimestamp] as Timestamp).toDate(),
        senderUid = json[kMessageSenderId] as String,
        text = json[kMessageText] as String,
        sender = json[kMessageSenderName] as String;

  Map<String, dynamic> toJson() => {
        kMessageTimestamp: Timestamp.fromDate(time),
        kMessageSenderId: senderUid,
        kMessageText: text,
        kMessageSenderName: sender,
      };
}
