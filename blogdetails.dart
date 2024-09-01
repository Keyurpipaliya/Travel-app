import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/bolgcomment.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:http/http.dart' as http;

class BlogDetail extends StatefulWidget {
  var bid;
  var bname;
  var bimg;
  var bimg1;
  var bvideo;
  var bdescription;
  var bauthor;
  var totallike;
   BlogDetail({super.key,this.bid,this.bname,this.bimg,this.bimg1,this.bvideo,this.bdescription,this.bauthor,this.totallike});

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  var imgurl = UrlResource.blogimg;

  bool islike=false;

  var totallike="0";

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.parse(UrlResource.BOLGDETAILS);
    var respoce = await http.post(uri,body: {"bid":widget.bid.toString(),"cid":prefs.getString("id").toString()});
    if (respoce.statusCode == 200) {
      var body = respoce.body.toString();
      var json = jsonDecode(body);
      log(widget.bid.toString());
      setState(() {
        totallike = json["totallike"].toString();
      });
      if(json["totallike"]=="0")
      {
        setState(() {
          islike=false;
        });

      }
      else
      {
        setState(() {
          islike=true;
        });
      }
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "BlogDetail",
          style:  TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  widget.bname.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.person_pin_outlined),
                    const SizedBox(width: 10),
                     Text(
                         widget.bauthor.toString(),
                       style: blackTextStyle.copyWith(
                         fontSize: 15,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                    const SizedBox(width: 120),
                    IconButton(onPressed: () async {
                      SharedPreferences prefs =await SharedPreferences.getInstance();
                      var cid = prefs.getString("id").toString();
                      Uri uri = Uri.parse(UrlResource.BLOGLIKE);

                      if(islike)
                      {
                        setState(() {
                          islike=false;
                        });
                      }
                      else
                      {
                        setState(() {
                          islike=true;
                        });
                      }

                      print(cid);
                      print(widget.bid.toString());

                      var respoce = await http.post(uri,
                        body: {
                          "cid":cid,
                          "bid":widget.bid.toString(),
                          "like":"like"
                        },
                      );
                      if (respoce.statusCode == 200) {
                        var body = respoce.body.toString();
                        print("body = ${body}");
                      } else {
                        print("error");
                      }
                    }, icon:  Icon(Icons.favorite,color: (islike)?Colors.red:Colors.black,),),
                    Text(totallike),
                    IconButton(onPressed: (){
                      Routes.instance
                          .push(widget:  CommentPage(id: widget.bid) , context: context);
                     }, icon: const Icon(Icons.rate_review_outlined),),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: [

                    //1st Image of Slider
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(imgurl + widget.bimg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(imgurl + widget.bimg1),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // //3rd Image of Slider
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     image: DecorationImage(
                    //       image: NetworkImage(imgurl + widget.pvideo),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    height: 250.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
                const  SizedBox(height: 15),
                Text(
                  "About",
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(widget.bdescription.toString(),
                  style: grayTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}