import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../constants/UrlResource.dart';
class RatePage extends StatefulWidget {
  var id = "";
  RatePage({required this.id});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {



  var rat=0.0;
  Future<List<dynamic>?>? alldata;
  Future<List<dynamic>?>? getdata() async {
    Uri uri = Uri.parse(UrlResource.GET_REVIEW);
    var respoce = await http.post(uri,body: {"pid":widget.id});
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

  TextEditingController _review = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Rating & Review",
          style:  TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
               setState(() {
                 rat = rating;
               });
              },
            ),
            TextFormField(
              controller: _review,
              decoration: const InputDecoration(
                labelText: 'Enter your review',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Submit",
              onPressed: () async{

                if(rat>=1)
                  {
                    SharedPreferences prefs = await SharedPreferences
                        .getInstance();
                    Uri uri = Uri.parse(UrlResource.ADD_REVIEW);
                    var respoce = await http.post(uri, body: {
                      "cid": prefs.getString("id").toString(),
                      "pid": widget.id,
                      "rating":rat.toString(),
                      "review":_review.text.toString()
                    });
                    if (respoce.statusCode == 200)
                    { var body = respoce.body.toString();
                    print(body);
                    setState(() {
                      alldata = getdata();
                    });
                    }
                  }
                else
                  {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                        SnackBar(content: Text("Please select rating")));
                  }


              },
            ),
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
                        // scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(defaultRadius),
                                color: Colors.grey.shade200,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data![index]["customer_name"]
                                            .toString(),
                                          style: blackTextStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: medium,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(snapshot.data![index]["review"]
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
                                    child: Text(snapshot.data![index]["rating"]
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
            )
          ],
        ),
      ),
    );
  }
}

