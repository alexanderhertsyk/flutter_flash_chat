import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
}

abstract class BaseScreenState<TScreen extends StatefulWidget>
    extends State<TScreen> {
  bool _isLoading = false;

  void setLoading(bool value) => setState(() => _isLoading = value);

  void log(Object e, StackTrace st) {
    print('Exception: $e');
    print('StackTrace: $st');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: buildBody(context),
      ),
    );
  }

  @protected
  Widget buildBody(BuildContext context);
}
