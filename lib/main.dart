import 'package:flutter/material.dart';
import 'package:galaxy/provider/liked_provider.dart';
import 'package:galaxy/provider/slider_provider.dart';
import 'package:galaxy/provider/theme_provider.dart';
import 'package:galaxy/views/detail_page.dart';
import 'package:galaxy/views/favouritepage.dart';
import 'package:galaxy/views/homePage.dart';
import 'package:galaxy/views/introScreen.dart';
import 'package:galaxy/views/splaceScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SliderProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => FavouriteProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'SplaceScreen',
      routes: {
        '/': (context) => Homepage(),
        'DetailPage': (context) => DetailPage(),
        'SplaceScreen': (context) => SplaceScreen(),
        'Introscreen': (context) => Introscreen(),
        'Favouritepage': (context) => Favouritepage(),
      },
    ),
  ));
}
