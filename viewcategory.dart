import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelingapp/Screen/pakagedisplay.dart';

import '../constants/UrlResource.dart';
import '../constants/theme_google.dart';

class ViewCategory extends StatefulWidget {
  const ViewCategory({super.key});

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  Future<List<dynamic>?>? alldata;
  var imgurl = UrlResource.catimg;

  Future<List<dynamic>?>? getdata() async {
    print(imgurl);
    Uri uri = Uri.parse(UrlResource.CATEGORY);
    var respoce = await http.post(uri,);
    if (respoce.statusCode == 200) {
      var body = respoce.body.toString();
      print(body);
      var json = jsonDecode(body);
      // print(json["data"]);
      return json["data"];
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Category",
              style: whiteTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length <= 0) {
              return Center(
                child: Text("No Data"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>pakagedisplay(id: snapshot.data![index]["category_id"]
                            .toString(),name:snapshot.data![index]
                        ["category_name"]
                            .toString() ,))
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Container(
                            height: 160,
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius),
                                  child: Image.network(
                                    imgurl +
                                        snapshot.data![index]["category_image"]
                                            .toString(),
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius:
                                        BorderRadius.circular(defaultRadius),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            snapshot.data![index]
                                                    ["category_name"]
                                                .toString(),
                                            style: whiteTextStyle.copyWith(
                                              fontSize: 45,
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
