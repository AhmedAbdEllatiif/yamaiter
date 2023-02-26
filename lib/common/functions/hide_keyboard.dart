import 'dart:developer';

import 'package:flutter/material.dart';

void hideKeyboard() {
  try {
    FocusManager.instance.primaryFocus?.unfocus();
  } catch (e) {
    log("hideKeyboard >> Error: $e");
  }
}
