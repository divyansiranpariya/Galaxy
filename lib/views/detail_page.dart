import 'package:flutter/material.dart';
import 'package:galaxy/utils/global.dart';
import 'package:readmore/readmore.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     IconButton(
                  //         onPressed: () {
                  //           Navigator.of(context).pop();
                  //         },
                  //         icon: Icon(
                  //           Icons.cancel,
                  //           size: 30,
                  //         )),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 200,
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.cancel,
                                size: 30,
                              )),
                        ),
                        Container(
                          height: 280,
                          width: 225,
                          margin: EdgeInsets.only(left: 25, top: 20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(alldata['image']))),
                        )
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
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50))),
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
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white70,
                                    size: 25,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.save_alt_outlined,
                                    color: Colors.white70,
                                    size: 25,
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white70.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Position",
                                  style: Textstyling.title,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  alldata['position'],
                                  style: Textstyling.subtitle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white70.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "velocity",
                                  style: Textstyling.title,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  alldata['velocity'],
                                  style: Textstyling.subtitle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white70.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "distance",
                                  style: Textstyling.title,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  alldata['distance'],
                                  style: Textstyling.subtitle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
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
            )
          ],
        ),
      ),
    );
  }
}
