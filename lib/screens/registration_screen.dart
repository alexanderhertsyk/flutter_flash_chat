import 'package:flash_chat/components/loading_indicator.dart';
import 'package:flash_chat/components/logger.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const route = '/registration';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with LoadingIndicator<RegistrationScreen>, Logger {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> _tryRegister() async {
    setLoading(true);

    try {
      var creds = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (creds.user != null) {
        creds.user!.updateDisplayName(_nicknameController.text);
      }

      return true;
    } catch (e, st) {
      log(e, st);

      return false;
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget buildChild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: Hero(
              tag: kHeroLogo,
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            decoration: kEmailDecoration,
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: _nicknameController,
            keyboardType: TextInputType.name,
            textAlign: TextAlign.center,
            decoration: kNicknameDecoration,
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            textAlign: TextAlign.center,
            decoration: kPasswordDecoration,
          ),
          const SizedBox(
            height: 24.0,
          ),
          RoundedButton(
            title: 'Register',
            color: Colors.blueAccent,
            onPressed: () {
              _tryRegister().then((registered) {
                if (registered) {
                  Navigator.pushNamed(context, ChatScreen.route);
                  _emailController.clear();
                  _nicknameController.clear();
                  _passwordController.clear();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
