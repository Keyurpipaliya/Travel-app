import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/seatpage.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:http/http.dart' as http;

class BusDetail extends StatefulWidget {
  var id;
  BusDetail({super.key, this.id});

  @override
  State<BusDetail> createState() => _BusDetailState();
}

class _BusDetailState extends State<BusDetail> {
  Future<List<dynamic>?>? alldata;
  var imgurl = UrlResource.busimg;

  Future<List<dynamic>?>? getdata() async {
    print(imgurl);
    Uri uri = Uri.parse(Uri Resource.BUS);
    SharedPreferences prefs = await SharedPreferences
        .getInstance();
    var respoce = await http.post(uri, body: {"id": widget.id,"cityid":prefs.getString("cityid")});
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
          "Select Bus",
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
                      Routes.instance
                          .push(widget:  SeatPage(id: snapshot.data![index]["bus_id"].toString(),), context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 178,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          color: Colors.grey.shade200,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(defaultRadius),
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          imgurl +
                                              snapshot.data![index]
                                                      ["seat_image"]
                                                  .toString(),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 135),
                                        child: Text(
                                          snapshot.data![index]["bus_type"]
                                              .toString(),
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: medium,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            "BusNo :- ",
                                            style: blackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index]["bus_number"]
                                                .toString(),
                                            style: grayTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data![index]["city_name"]
                                                .toString(),
                                            style: blackTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: medium,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 3),
                                          Container(
                                            width: 20,
                                            height: 2,
                                            color: primaryColor,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            snapshot.data![index]
                                                    ["package_title"]
                                                .toString(),
                                            style: blackTextStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: medium,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Date :- ",
                                            style: blackTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data![index]["sdate"]
                                                .toString(),
                                            style: grayTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                          Text(
                                            "Time :- ",
                                            style: blackTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data![index]["stime"]
                                                .toString(),
                                            style: grayTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Address :- ",
                                            style: blackTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data![index]["bus_addres"]
                                                .toString(),
                                            style: grayTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
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
