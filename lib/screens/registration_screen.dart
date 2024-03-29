import 'package:flash_chat/constants.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const route = '/registration';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _setLoading(bool value) => setState(() => _isLoading = value);

  void _resetController(TextEditingController controller) {
    controller.value = controller.value.copyWith(
      text: null,
      selection: TextSelection.collapsed(
        offset: controller.text.length,
      ),
    );
  }

  Future<bool> _tryRegister() async {
    _setLoading(true);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.value.text,
        password: _passwordController.value.text,
      );
      return true;
    } catch (e) {
      print(e);

      return false;
    } finally {
      _setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: _build(context),
      ),
    );
  }

  Widget _build(BuildContext context) {
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
                }
                setState(() {
                  _resetController(_emailController);
                  _resetController(_passwordController);
                });
              });
            },
          ),
        ],
      ),
    );
  }
}
