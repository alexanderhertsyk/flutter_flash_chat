import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/loading_indicator.dart';
import 'package:flash_chat/components/logger.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/extensions/text_editing_controller_extension.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with LoadingIndicator<LoginScreen>, Logger {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> _tryLogin() async {
    setLoading(true);

    try {
      await _auth.signInWithEmailAndPassword(
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
            title: 'Log In',
            onPressed: () {
              _tryLogin().then((logged) {
                if (logged) {
                  Navigator.pushNamed(context, ChatScreen.route);
                  setState(() {
                    _emailController.resetValue();
                    _passwordController.resetValue();
                  });
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
