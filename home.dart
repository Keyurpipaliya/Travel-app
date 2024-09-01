import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/pakagedetails.dart';
import 'package:travelingapp/Screen/searchpage.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/theme_google.dart';

import '../constants/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<dynamic>?>? alldata;
  Future<List<dynamic>?>? alldata1;
  var imgurl = UrlResource.packimg;

  Future<List<dynamic>?>? getdata1() async {
    print(imgurl);
    Uri uri = Uri.parse(UrlResource.HOME1);
    var respoce = await http.post(uri);
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

  Future<List<dynamic>?>? getdata() async {
    print(imgurl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.parse(UrlResource.HOME2);
    var respoce = await http.post(uri,body: {"cid":prefs.getString("id").toString()});
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
      alldata1 = getdata1();
    });
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
              "Travel Guru",
              style: whiteTextStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      Routes.instance
                          .push(widget: const SearchPage(), context: context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
              child: Text(
                "Recommended",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 318.0,
              margin: EdgeInsets.only(bottom: 10.0),
              child: FutureBuilder(
                future: alldata1,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length <= 0) {
                      return Center(
                        child: Text("No Data"),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
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
                            child:Container(
                              width: 210,
                              height: 327,
                              margin: const EdgeInsets.only(left: 15),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(defaultRadius),
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 190,
                                      height: 230,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(defaultRadius),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              imgurl +
                                                  snapshot.data![index]["package_image"]
                                                      .toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 55,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(defaultRadius),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    "assets/images/icons8-star-48.png"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                snapshot.data![index]["totalrating"]
                                                    .toString()=="null"?"0":snapshot.data![index]["totalrating"]
                                                    .toString(),
                                                style: blackTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: medium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index]["package_title"]
                                                .toString(),
                                            style: blackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          const SizedBox(height: 5),

                                        ],
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
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
              child: Text(
                  "New This Year",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder(
              future: alldata,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length <= 0) {
                    return Center(
                      child: Text("No Data"),
                    );
                  } else {
                    return Column(
                      children: snapshot.data!.map((e){
                        return GestureDetector(
                          onTap: () {
                            Routes.instance.push(
                                widget: pakagedetails(
                                    pid: e["package_id"]
                                        .toString(),
                                    pname: e
                                    ["package_title"]
                                        .toString(),
                                    pimg: e
                                    ["package_image"]
                                        .toString(),
                                    pimg1: e
                                    ["package_image1"]
                                        .toString(),
                                    pvideo: e
                                    ["package_video"]
                                        .toString(),
                                    pdescription: e
                                    ["package_description"]
                                        .toString(),
                                    padddatetime: e
                                    ["package_datetime"]
                                        .toString(),
                                    pschedule: e
                                    ["package_schedule"]
                                        .toString(),
                                    pdays: e
                                    ["package_days"]
                                        .toString(),
                                    pactive: e
                                    ["package_active"]
                                        .toString(),
                                    pavailableseat_ac: e
                                    ["total_seat_ac"]
                                        .toString(),
                                    pavailablenonseat_ac: e
                                    ["total_seat_non_ac"]
                                        .toString(),
                                    pstartdate: e
                                    ["start_date"]
                                        .toString(),
                                    penddate: e
                                    ["end_date"]
                                        .toString(),
                                  totallike: e
                                ["totallike"]
                                    .toString(),),
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
                                            e["package_image"]
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
                                          e["package_title"]
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
                                      e["totalrating"]
                                          .toString()=="null"?"0":e["totalrating"]
                                          .toString(),
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
                      }).toList(),
                    );
                    // return ListView.builder(
                    //   itemCount: snapshot.data!.length,
                    //   itemBuilder: (context, index) {
                    //     return GestureDetector(
                    //       onTap: () {
                    //         Routes.instance.push(
                    //             widget: pakagedetails(
                    //                 pid: snapshot.data![index]["package_id"]
                    //                     .toString(),
                    //                 pname: snapshot.data![index]
                    //                         ["package_title"]
                    //                     .toString(),
                    //                 pimg: snapshot.data![index]
                    //                 ["package_image"]
                    //                     .toString(),
                    //                 pimg1: snapshot.data![index]
                    //                 ["package_image1"]
                    //                     .toString(),
                    //                 pvideo: snapshot.data![index]
                    //                 ["package_video"]
                    //                     .toString(),
                    //                 pdescription: snapshot.data![index]
                    //                         ["package_description"]
                    //                     .toString(),
                    //                 padddatetime: snapshot.data![index]
                    //                         ["package_datetime"]
                    //                     .toString(),
                    //                 pschedule: snapshot.data![index]
                    //                 ["package_schedule"]
                    //                     .toString(),
                    //                 pdays: snapshot.data![index]
                    //                 ["package_days"]
                    //                     .toString(),
                    //                 pactive: snapshot.data![index]
                    //                 ["package_active"]
                    //                     .toString(),
                    //                 pavailableseat_ac: snapshot.data![index]
                    //                 ["total_seat_ac"]
                    //                     .toString(),
                    //                 pavailablenonseat_ac: snapshot.data![index]
                    //                 ["total_seat_non_ac"]
                    //                     .toString(),
                    //                 pstartdate: snapshot.data![index]
                    //                 ["start_date"]
                    //                     .toString(),
                    //                 penddate: snapshot.data![index]
                    //                 ["end_date"]
                    //                     .toString()),
                    //             context: context);
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.all(10),
                    //         margin: const EdgeInsets.only(bottom: 16),
                    //         decoration: BoxDecoration(
                    //           borderRadius:
                    //               BorderRadius.circular(defaultRadius),
                    //           color: Colors.grey.shade200,
                    //         ),
                    //         child: Row(
                    //           children: [
                    //             Container(
                    //               width: 70,
                    //               height: 70,
                    //               decoration: BoxDecoration(
                    //                 borderRadius:
                    //                     BorderRadius.circular(defaultRadius),
                    //                 image: DecorationImage(
                    //                   image: NetworkImage(imgurl +
                    //                       snapshot.data![index]["package_image"]
                    //                           .toString()),
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(width: 16),
                    //             Expanded(
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     snapshot.data![index]["package_title"]
                    //                         .toString(),
                    //                     style: blackTextStyle.copyWith(
                    //                       fontSize: 18,
                    //                       fontWeight: medium,
                    //                     ),
                    //                     overflow: TextOverflow.ellipsis,
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             const Image(
                    //               image: AssetImage(
                    //                   "assets/images/icons8-star-48.png"),
                    //               width: 25,
                    //               height: 25,
                    //             ),
                    //             const SizedBox(width: 5),
                    //             Padding(
                    //               padding: const EdgeInsets.only(right: 10),
                    //               child: Text(
                    //                 "4.3",
                    //                 style: blackTextStyle.copyWith(
                    //                   fontSize: 16,
                    //                   fontWeight: medium,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      )
    );
  }
}
