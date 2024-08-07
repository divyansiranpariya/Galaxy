import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

import '../provider/slider_provider.dart';
import '../provider/theme_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  Future<String>? jsonData;
  late AnimationController animationController;
  late Animation<double> rotateAnimation;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    loadJson();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    rotateAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 2 * pi), weight: 2),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: pi), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: pi / 2), weight: 2),
    ]).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0, 0.5)),
    );

    sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.7, end: 0.12), weight: 3),
      TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 1), weight: 3),
      TweenSequenceItem(tween: Tween<double>(begin: 0.4, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.5, 1)),
    );
  }

  void loadJson() {
    jsonData = rootBundle.loadString("assets/json/planate_data.json");
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  CarouselController carouselController = CarouselController();

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
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 150, left: 230),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('Favouritepage');
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          size: 30,
                          color: Colors.red.withOpacity(0.6),
                        )),
                    IconButton(
                        onPressed: () {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme();
                        },
                        icon: Icon(
                          Icons.nightlight,
                          size: 30,
                          color: Colors.indigo.withOpacity(0.6),
                        )),
                  ],
                ),
              ),
              FutureBuilder<String>(
                future: jsonData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text("No Data available"));
                  }

                  List<dynamic> alldata = jsonDecode(snapshot.data!);
                  return CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      //autoPlay: true,
                      pageSnapping: true,
                      initialPage:
                          Provider.of<SliderProvider>(context).sliderindex,
                      onPageChanged: (val, _) {
                        Provider.of<SliderProvider>(context, listen: false)
                            .changeslide(val);
                      },
                    ),
                    items: alldata.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('DetailPage', arguments: e);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 400,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Color(0xFF1A1D24).withOpacity(0.7),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AnimatedBuilder(
                                  animation: animationController,
                                  builder: (context, _) {
                                    return Transform.scale(
                                      scale: sizeAnimation.value,
                                      child: Transform.rotate(
                                        angle: rotateAnimation.value,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 9, bottom: 15),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(e['image']),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  e['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    carouselController: carouselController,
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 240, bottom: 50),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white70.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        animationController.forward();
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        size: 30,
                        color: Colors.white70,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        animationController.repeat();
                      },
                      icon: Icon(
                        Icons.repeat,
                        size: 30,
                        color: Colors.white70,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        animationController.reverse();
                      },
                      icon: Icon(
                        Icons.refresh_sharp,
                        size: 30,
                        color: Colors.white70,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        animationController.stop();
                      },
                      icon: Icon(
                        Icons.stop,
                        size: 30,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
