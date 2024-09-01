import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelingapp/Screen/pakagedetails.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:http/http.dart' as http;

class pakagedisplay extends StatefulWidget {
  var id;
  var name;
  pakagedisplay({super.key, this.id, this.name});

  @override
  State<pakagedisplay> createState() => _pakagedisplayState();
}

class _pakagedisplayState extends State<pakagedisplay> {
  Future<List<dynamic>?>? alldata;
  var imgurl = UrlResource.packimg;

  Future<List<dynamic>?>? getdata() async {
    print(imgurl);
    Uri uri = Uri.parse(UrlResource.VIEWPACK);
    var respoce = await http.post(
      uri,
      body: {"cid": widget.id},
    );
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
          widget.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 35,
                              child: Material(
                                elevation: 0.0,
                                child: Container(
                                  height: 150,
                                  width: 370,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 10,
                              child: Card(
                                elevation: 10.0,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  height: 170,
                                  width: 135,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(imgurl +
                                          snapshot.data![index]["package_image"]
                                              .toString()),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              right: 20,
                              child: Container(
                                height: 200,
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Package Days :- ",
                                          style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: medium,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          snapshot.data![index]["package_days"]
                                              .toString(),
                                          style: grayTextStyle.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Booking Date : ",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: medium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Start Date :- ",
                                            style: blackTextStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data![index]["start_date"]
                                                .toString(),
                                            style: grayTextStyle.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            "End Date   :- ",
                                            style: blackTextStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data![index]["end_date"]
                                                .toString(),
                                            style: grayTextStyle.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
    );
  }
}
