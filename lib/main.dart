import 'package:flutter/material.dart';
import 'package:flutter_test_mlkit_app/app.dart';
import 'package:saas_mlkit/saas_mlkit.dart';

Future<void> main() async {
  await SaasMLKit.init(useLogger: true);
  runApp(const MyApp());
}
