const kMessageSenderId = 'senderId';
const kMessageText = 'text';
const kMessageSenderName = 'senderName';

class MessageModel {
  final String senderUid;
  final String text;
  final String sender;

  MessageModel(
      {required this.senderUid, required this.text, required this.sender});

  MessageModel.fromJson(Map<String, dynamic> json)
      : senderUid = json[kMessageSenderId] as String,
        text = json[kMessageText] as String,
        sender = json[kMessageSenderName] as String;

  Map<String, dynamic> toJson() => {
        kMessageSenderId: senderUid,
        kMessageText: text,
        kMessageSenderName: sender,
      };
}
