const kMessageText = 'text';
const kMessageSender = 'sender';

class MessageModel {
  final String text;
  final String sender;

  MessageModel({required this.text, required this.sender});

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json[kMessageText] as String,
        sender = json[kMessageSender] as String;

  Map<String, dynamic> toJson() => {
        kMessageText: text,
        kMessageSender: sender,
      };
}
