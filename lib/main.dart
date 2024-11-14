import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/settings_provider.dart';

import 'firebase_options.dart';
import 'my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // بقفل الانترنت عشان الداتا تتخزن local
  await FirebaseFirestore.instance.disableNetwork();
  //await FirebaseFirestore.instance.enableNetwork();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => SettingsProvider(), child: MyApp()));
}
