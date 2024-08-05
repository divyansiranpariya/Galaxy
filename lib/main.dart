import 'package:flutter/material.dart';
import 'package:galaxy/views/detail_page.dart';
import 'package:galaxy/views/homePage.dart';
import 'package:provider/provider.dart';

import 'controller/slider_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SliderProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Homepage(),
        'DetailPage': (context) => DetailPage(),
      },
    ),
  ));
}
