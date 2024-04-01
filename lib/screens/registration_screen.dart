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
  final _passwordController = TextEditingController();

  Future<bool> _tryRegister() async {
    setLoading(true);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.value.text,
        password: _passwordController.value.text,
      );

      return true;
    } catch (e, st) {
      log(e, st);

      return false;
    } finally {
      setLoading(false);
    }
  }

  @override
  Widget buildChild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Hero(
            tag: kHeroLogo,
            child: SizedBox(
              height: 200.0,
              child: Image.asset('images/logo.png'),
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
