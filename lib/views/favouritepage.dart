import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:galaxy/provider/liked_provider.dart';
import 'package:galaxy/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favouritepage extends StatefulWidget {
  const Favouritepage({super.key});

  @override
  State<Favouritepage> createState() => _FavouritepageState();
}

class _FavouritepageState extends State<Favouritepage> {
  @override
  Widget build(BuildContext context) {
    var favouriteProvider = Provider.of<FavouriteProvider>(context);
    var favouriteItems = favouriteProvider.allfav;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/image/solar.jpeg"),
          ),
        ),
        child: (favouriteItems.isEmpty)
            ? Center(
                child: Text(
                  "NO FAVOURITE ANY ITEM YET...",
                  style: Textstyling.title,
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                itemBuilder: (context, i) {
                  var item = favouriteItems[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('Detail_page', arguments: item);
                    },
                    child: Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Color(0xFF1A1D24).withOpacity(0.7),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30, left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${Textstyling.savename}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Position:",
                                        style: Textstyling.title,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${item['position']}",
                                        style: Textstyling.subtitle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Name:",
                                        style: Textstyling.title,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${item['name']}",
                                        style: Textstyling.subtitle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Velocity:",
                                        style: Textstyling.title,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${item['velocity']}",
                                        style: Textstyling.subtitle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            favouriteProvider.removeData(
                                                map: item);
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.white70,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return SizedBox(height: 20);
                },
                itemCount: favouriteItems.length,
              ),
      ),
    );
  }
}
