import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({super.key});

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/image/solar.jpeg"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  width: 300,
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
                    padding: EdgeInsets.only(top: 45, left: 60),
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
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (context) => false);
                SharedPreferences sharedPreference =
                    await SharedPreferences.getInstance();
                sharedPreference.setBool("intro", true);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
