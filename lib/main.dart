import 'package:flutter/material.dart';

import 'package:formusers/AppProvider.dart';
import 'package:formusers/dependencies_injection.dart' as dependencies;



void main() async {
  await dependencies.init();
  runApp(App());
}


