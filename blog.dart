import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelingapp/Screen/blogdetails.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';

import 'package:http/http.dart' as http;

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  Future<List<dynamic>?>? alldata;
  var imgurl = UrlResource.blogimg;

  Future<List<dynamic>?>? getdata() async {
    print(imgurl);
    Uri uri = Uri.parse(UrlResource.BLOG);
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
              "Blogs",
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
                      Routes.instance.push(widget: BlogDetail(
                        bid: snapshot.data![index]
                        ["blog_id"]
                            .toString(),
                        bname: snapshot.data![index]
                        ["blog_title"]
                            .toString(),
                        bimg: snapshot.data![index]
                        ["blog_image"]
                            .toString(),
                        bimg1: snapshot.data![index]
                        ["blog_image1"]
                            .toString(),
                        bvideo: snapshot.data![index]
                        ["blog_video"]
                            .toString(),
                        bdescription: snapshot.data![index]
                        ["blog_content"]
                            .toString(),
                        bauthor: snapshot.data![index]
                        ["blog_author"]
                            .toString(),
                        totallike: snapshot.data![index]
                        ["totallike"]
                            .toString(),
                      ), context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          color: Colors.grey.shade300,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 170,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    imgurl +
                                        snapshot.data![index]["blog_image"]
                                            .toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                              snapshot.data![index]
                                  ["blog_title"]
                                  .toString(),
                                    style: blackTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                             Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                const  Icon(Icons.person_pin_outlined),
                                const  SizedBox(width: 10),
                                  Text(
                                    snapshot.data![index]
                                    ["blog_author"]
                                        .toString(),
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
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
