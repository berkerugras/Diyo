import 'package:flutter/material.dart';
import 'AddScreen.dart';
import 'MainMenu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'MyHomePage.dart';
import 'package:provider/provider.dart';

import 'list_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diyo!',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ChangeNotifierProvider<ListProvider>(
        create: (context) => ListProvider(),
        child: MyHomePage(),
      ),
    );
  }
}
