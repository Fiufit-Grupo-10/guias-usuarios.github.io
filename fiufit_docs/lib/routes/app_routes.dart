import 'package:fiufit_docs/screens/doc_page.dart';
import 'package:fiufit_docs/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => HomePage(),
    'doc': (BuildContext context) => DocPage(),
  };
}
