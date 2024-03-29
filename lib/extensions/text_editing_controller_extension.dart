import 'package:flutter/material.dart';

extension TextEditingControlllerExtension on TextEditingController {
  void resetValue() {
    value = value.copyWith(
      text: null,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
  }
}
