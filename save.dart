import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/pakagedetails.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/theme_google.dart';

import '../constants/routes.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  Future<List<dynamic>?>? alldata;
  var imgurl = UrlResource.packimg;

  Future<List<dynamic>?>? getdata() async {
    print(imgurl);
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var cid = prefs.getString("id").toString();
    Uri uri = Uri.parse(UrlResource.MYFAV);
    var respoce = await http.post(uri,body: {"cid":cid});
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Bookmark",
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
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
                            Routes.instance.push(
                                widget: pakagedetails(
                                    pid: snapshot.data![index]["package_id"]
                                        .toString(),
                                    pname: snapshot.data![index]
                                    ["package_title"]
                                        .toString(),
                                    pimg: snapshot.data![index]
                                    ["package_image"]
                                        .toString(),
                                    pimg1: snapshot.data![index]
                                    ["package_image1"]
                                        .toString(),
                                    pvideo: snapshot.data![index]
                                    ["package_video"]
                                        .toString(),
                                    pdescription: snapshot.data![index]
                                    ["package_description"]
                                        .toString(),
                                    padddatetime: snapshot.data![index]
                                    ["package_datetime"]
                                        .toString(),
                                    pschedule: snapshot.data![index]
                                    ["package_schedule"]
                                        .toString(),
                                    pdays: snapshot.data![index]
                                    ["package_days"]
                                        .toString(),
                                    pactive: snapshot.data![index]
                                    ["package_active"]
                                        .toString(),
                                    pavailableseat_ac: snapshot.data![index]
                                    ["total_seat_ac"]
                                        .toString(),
                                    pavailablenonseat_ac: snapshot.data![index]
                                    ["total_seat_non_ac"]
                                        .toString(),
                                    pstartdate: snapshot.data![index]
                                    ["start_date"]
                                        .toString(),
                                    penddate: snapshot.data![index]
                                    ["end_date"]
                                        .toString()),
                                context: context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(defaultRadius),
                                color: Colors.grey.shade200,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(defaultRadius),
                                      image: DecorationImage(
                                        image: NetworkImage(imgurl +
                                            snapshot.data![index]["package_image"]
                                                .toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index]["package_title"]
                                              .toString(),
                                          style: blackTextStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: medium,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Image(
                                    image: AssetImage(
                                        "assets/images/icons8-star-48.png"),
                                    width: 25,
                                    height: 25,
                                  ),
                                  const SizedBox(width: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "4.3",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: medium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
          ),
        ],
      ),
    );
  }
}
