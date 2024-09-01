import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import '../constants/UrlResource.dart';
class CommentPage extends StatefulWidget {
  var id = "";
  CommentPage({required this.id});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {


  Future<List<dynamic>?>? alldata;
  Future<List<dynamic>?>? getdata() async {
    Uri uri = Uri.parse(UrlResource.COMMENT);
    var respoce = await http.post(uri,body: {"bid":widget.id});
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

  TextEditingController _comment = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Comment",
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
            TextFormField(
              controller: _comment,
              decoration: const InputDecoration(
                labelText: 'Enter your Comment',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Submit",
              onPressed: () async{


                var cm = _comment.text.toString();
                print(cm);
                if(_comment.text!="")
                {
                  SharedPreferences prefs = await SharedPreferences
                      .getInstance();
                  Uri uri = Uri.parse(UrlResource.ADDCOMMENT);
                  print(prefs.getString("id").toString());
                  print(widget.id);
                  print(cm);
                  var respoce = await http.post(uri, body: {
                    "cid": prefs.getString("id").toString(),
                    "bid": widget.id,
                    "comment":cm
                  });
                  if (respoce.statusCode == 200)
                  {
                    var body = respoce.body.toString();
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
                      SnackBar(content: Text("Please Enter Comment")));
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
                                        Text(snapshot.data![index]["comment"]
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

