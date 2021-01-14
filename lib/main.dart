import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/page_home.dart';
import 'ui/page_login.dart';
import 'ui/page_settings.dart';
import 'utils/utils.dart';

void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ressources Relationnelles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CollectionApp(),
    );
  }
}

class CollectionApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
        ),
        home: HomePage()
    );
  }
}