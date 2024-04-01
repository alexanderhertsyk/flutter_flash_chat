import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const kMessages = 'messages';
const kMessageText = 'text';
const kMessageSender = 'sender';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const route = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with LoadingIndicator {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User _loggedUser;
  String? _messageText;

  @override
  void initState() {
    super.initState();

    _trySetUser();
  }

  void _trySetUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _loggedUser = user;
        print(_loggedUser);
      } else {
        _logout();
      }
    } catch (e) {
      print(e);
      _logout();
    }
  }

  Future<void> _logout() => _auth.signOut();

  void _sendMessage() {
    _firestore.collection(kMessages).add({
      kMessageText: _messageText,
      kMessageSender: _loggedUser.email,
    });
  }

  @override
  Widget buildParent(BuildContext context, Widget child) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _logout().then((value) => Navigator.pop(context)),
          ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection(kMessages).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data!.docs
                    .map((d) => d.data())
                    .whereType<Map<String, dynamic>>()
                    .map((m) =>
                        Text('${m[kMessageText]} from ${m[kMessageSender]}'))
                    .toList(),
              );
            } else {
              return const Expanded(child: Center(child: Text('No messages!')));
            }
          },
        ),
        Container(
          decoration: kMessageContainerDecoration,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  onChanged: (value) => _messageText = value,
                  decoration: kMessageTextFieldDecoration,
                ),
              ),
              TextButton(
                onPressed: () => _sendMessage(),
                child: const Text(
                  'Send',
                  style: kSendButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
