import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../provider/liked_provider.dart';
import '../utils/global.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> shareImage() async {
    try {
      RenderRepaintBoundary renderRepaintBoundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      var image = await renderRepaintBoundary.toImage(pixelRatio: 5);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List fetchImage = byteData!.buffer.asUint8List();

      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path;
      File file = File('$path/screenshot.png');

      await file.writeAsBytes(fetchImage);

      ShareExtend.share(file.path, "image");
    } catch (e) {
      print("Error sharing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Map alldata = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/image/solar.jpeg"),
        )),
        child: RepaintBoundary(
          key: _globalKey,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 200),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.cancel,
                                size: 30,
                              ),
                            ),
                          ),
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 200, end: 0),
                            curve: Curves.easeInOutSine,
                            duration: Duration(seconds: 3),
                            builder: (context, double position, _) {
                              return Transform.translate(
                                offset: Offset(position, 0),
                                child: TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0, end: 2 * pi),
                                  duration: Duration(seconds: 3),
                                  builder: (context, double rotation, _) {
                                    return Transform.rotate(
                                      angle: rotation,
                                      child: Container(
                                        height: 280,
                                        width: 225,
                                        margin:
                                            EdgeInsets.only(left: 25, top: 20),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(alldata['image']),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 440,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white70.withOpacity(0.1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              alldata['name'],
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Provider.of<FavouriteProvider>(context,
                                            listen: false)
                                        .addData(map: alldata);
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white70,
                                    size: 25,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    shareImage();
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white70,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white70.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Position",
                                    style: Textstyling.title,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    alldata['position'],
                                    style: Textstyling.subtitle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white70.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Velocity",
                                    style: Textstyling.title,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    alldata['velocity'],
                                    style: Textstyling.subtitle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white70.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Distance",
                                    style: Textstyling.title,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    alldata['distance'],
                                    style: Textstyling.subtitle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        ReadMoreText(
                          alldata['description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          trimLines: 4,
                          colorClickableText: Colors.green.shade300,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Read more',
                          trimExpandedText: 'Show less',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
