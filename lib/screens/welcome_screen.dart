import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/base_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends BaseScreen {
  const WelcomeScreen({super.key});

  static const route = '/';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends BaseScreenState<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _startAnimation();
    _initializeFirebase();
  }

  void _startAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      upperBound: 1,
      vsync: this,
    );
    _controller.addListener(() => setState(() {}));
    _animation = ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(_controller);
    _controller.forward();
  }

  Future<void> _initializeFirebase() async {
    setLoading(true);

    try {
      // TODO: move keys to config somehow?
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDqyICgarzmX5BigNu-jcTMmSEz1RF88e8',
              appId: '1:632267619026:android:25c64efe52ea4a07d28b0b',
              messagingSenderId: '632267619026',
              projectId: 'flash-chat-43149'));
    } catch (e, st) {
      log(e, st);
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      color: _animation.value,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Hero(
                tag: kHeroLogo,
                child: SizedBox(
                  height: 60,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText('Flash Chat',
                      speed: const Duration(milliseconds: 500),
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ))
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 48.0,
          ),
          RoundedButton(
            title: 'Log In',
            onPressed: () => Navigator.pushNamed(context, LoginScreen.route),
          ),
          RoundedButton(
            title: 'Register',
            color: Colors.blueAccent,
            onPressed: () =>
                Navigator.pushNamed(context, RegistrationScreen.route),
          ),
        ],
      ),
    );
  }
}
