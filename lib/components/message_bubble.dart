import 'package:flash_chat/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMyMessage;

  const MessageBubble(this.message, {required this.isMyMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(isMyMessage ? 0.0 : 30.0),
              topLeft: Radius.circular(isMyMessage ? 30.0 : 0.0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMyMessage ? Colors.lightBlueAccent : Colors.grey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isMyMessage ? Colors.white : Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Text(
            message.sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
