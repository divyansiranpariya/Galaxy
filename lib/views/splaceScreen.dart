import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (context) => false);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xFF1A1D24).withOpacity(0.7),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHXok5RLmHOhKmuFuj20hHvloT5a2IGj2brQ&s")),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 180, left: 70),
              child: Column(
                children: [
                  Text(
                    "Explore The",
                    style: TextStyle(color: Colors.white70, fontSize: 33),
                  ),
                  Text(
                    "Solar System",
                    style: TextStyle(color: Colors.white70, fontSize: 33),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
