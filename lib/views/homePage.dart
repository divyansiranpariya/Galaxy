import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/slider_provider.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  Future<String>? jsonData;
  late AnimationController animationController;
  late Animation rotateAnimation;
  @override
  void loadjson() {
    jsonData = rootBundle.loadString("assets/json/planate_data.json");
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    loadjson();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
  }

  CarouselController carouselController = CarouselController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/image/solar.jpeg"),
        )),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: jsonData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String? data = snapshot.data;
                      List alldata = (data == null) ? [] : jsonDecode(data);
                      return (data == null)
                          ? Center(
                              child: Text("NO Data available"),
                            )
                          : CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 0.9,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                pageSnapping: true,
                                initialPage: Provider.of<SliderProvider>(
                                  context,
                                ).sliderindex,
                                onPageChanged: (val, _) {
                                  Provider.of<SliderProvider>(context,
                                          listen: false)
                                      .changeslide(val);
                                },
                              ),
                              items: alldata
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            'DetailPage',
                                            arguments: e);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 400,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF1A1D24)
                                                .withOpacity(0.7),
                                            boxShadow: [
                                              // BoxShadow(
                                              //   color: Colors.white.withOpacity(0.6),
                                              //   blurRadius: 10,
                                              //   spreadRadius: 5,
                                              // )
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: [
                                            AnimatedBuilder(
                                              animation: animationController,
                                              builder: (context, _) {
                                                return Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 9, bottom: 15),
                                                      decoration: BoxDecoration(

                                                          // color: Colors.pink,
                                                          image:
                                                              DecorationImage(
                                                                  //
                                                                  image: NetworkImage(
                                                                      e['image']))),
                                                    ));
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                e['name'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white70),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              carouselController: carouselController,
                            );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("ERROR${snapshot.hasError}"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              Container(
                margin: EdgeInsets.only(top: 280, bottom: 50),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white70.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        )),
                    IconButton(
                        onPressed: () {
                          animationController.repeat();
                        },
                        icon: Icon(
                          Icons.repeat,
                          size: 30,
                          color: Colors.white70,
                        )),
                    IconButton(
                        onPressed: () {
                          animationController.reverse();
                        },
                        icon: Icon(
                          Icons.refresh_sharp,
                          size: 30,
                          color: Colors.white70,
                        )),
                    IconButton(
                        onPressed: () {
                          animationController.stop();
                        },
                        icon: Icon(
                          Icons.stop,
                          size: 30,
                          color: Colors.white70,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
