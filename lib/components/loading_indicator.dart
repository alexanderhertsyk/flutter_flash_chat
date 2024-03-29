import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

mixin LoadingIndicator<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  void setLoading(bool value) => setState(() => _isLoading = value);

  Widget buildParent(BuildContext context, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
    );
  }

  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildParent(
        context,
        ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: buildChild(context),
        ));
  }
}
