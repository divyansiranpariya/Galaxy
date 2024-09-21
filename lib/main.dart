import 'package:flutter/material.dart';
import 'package:galaxy/provider/liked_provider.dart';
import 'package:galaxy/provider/slider_provider.dart';
import 'package:galaxy/provider/theme_provider.dart';
import 'package:galaxy/utils/global.dart';
import 'package:galaxy/views/detail_page.dart';
import 'package:galaxy/views/favouritepage.dart';
import 'package:galaxy/views/homePage.dart';
import 'package:galaxy/views/introScreen.dart';
import 'package:galaxy/views/splaceScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  Textstyling.savename = pref.getString('name') ?? "false";

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SliderProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => FavouriteProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: (Provider.of<ThemeProvider>(context).themeModel.isdark)
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: 'Splace_screen',
      routes: {
        '/': (context) => Homepage(),
        'Detail_page': (context) => DetailPage(),
        'Splace_screen': (context) => SplaceScreen(),
        'Intro_screen': (context) => Introscreen(),
        'Favourite_page': (context) => Favouritepage(),
      },
    );
  }
}
