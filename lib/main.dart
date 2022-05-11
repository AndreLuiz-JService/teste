import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyCtjKzMoMydIDNv5RHQv9yee9VXNsjKL8I',
        appId: '1:143508559779:android:9f21b3d5b5e2b1b95b6c16',
        messagingSenderId: '143508559779',
        projectId: 'desafiopleno-97066',
        storageBucket: 'desafiopleno-97066.appspot.com',
      ),
  );
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
