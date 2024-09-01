import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/buspage.dart';
import 'package:travelingapp/Screen/rate_review.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import '../constants/UrlResource.dart';

class pakagedetails extends StatefulWidget {
  var pid;
  var pname;
  var pimg;
  var pimg1;
  var pvideo;
  var pdescription;
  var padddatetime;
  var pschedule;
  var pdays;
  var pactive;
  var pavailableseat_ac;
  var pavailablenonseat_ac;
  var pstartdate;
  var penddate;
  var totallike;
   pakagedetails({super.key,this.pid,this.pname,this.pimg,this.pimg1,this.pvideo,this.pdescription,this.padddatetime,this.pschedule,
     this.pdays,this.pactive,this.pavailableseat_ac,this.pavailablenonseat_ac,this.pstartdate,this.penddate,this.totallike});

  @override
  State<pakagedetails> createState() => _pakagedetailsState();
}

class _pakagedetailsState extends State<pakagedetails> {

  var imgurl = UrlResource.packimg;


  bool islike=false;
  bool isfav=false;

  var totallike="0";

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.parse(UrlResource.PKGDETAILS);
    var respoce = await http.post(uri,body: {"pid":widget.pid.toString(),"cid":prefs.getString("id").toString()});
    if (respoce.statusCode == 200) {
      var body = respoce.body.toString();
      var json = jsonDecode(body);
      log(widget.pid.toString());
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
      if(json["totalfav"]=="0")
      {
        setState(() {
          isfav=false;
        });

      }
      else
      {
        setState(() {
          isfav=true;
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
          "Detail",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (widget.pname.toString()),
                  style: blackTextStyle.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const SizedBox(width: 215),
                        IconButton(onPressed: ()async {

                          SharedPreferences prefs =await SharedPreferences.getInstance();
                          var cid = prefs.getString("id").toString();
                          Uri uri = Uri.parse(UrlResource.PKGLIKE);

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

                          var respoce = await http.post(uri,
                            body: {
                              "cid":cid,
                              "pid":widget.pid.toString()
                            },
                          );
                          if (respoce.statusCode == 200) {
                            var body = respoce.body.toString();
                          } else {
                            print("error");
                          }

                          getdata();

                        }, icon: Icon(Icons.favorite,color: (islike)?Colors.red:Colors.black,)),
                        Text(totallike),
                    IconButton(onPressed: (){
                      Routes.instance
                          .push(widget:  RatePage(id: widget.pid,) , context: context);
                     }, icon: const Icon(Icons.rate_review_outlined),
                    ),
                    IconButton(onPressed: () async{
                      if(isfav)
                      {
                        setState(() {
                          isfav=false;
                        });
                      }
                      else
                      {
                        setState(() {
                          isfav=true;
                        });
                      }


                      SharedPreferences prefs =await SharedPreferences.getInstance();
                      var cid = prefs.getString("id").toString();
                      Uri uri = Uri.parse(UrlResource.ADD_BOOK);


                      var respoce = await http.post(uri,
                        body: {
                          "cid":cid,
                          "pid":widget.pid.toString()
                        },
                      );
                      if (respoce.statusCode == 200) {
                        var body = respoce.body.toString();
                      } else {
                        print("error");
                      }
                    }, icon:  Icon(Icons.bookmark,color: (isfav)?Colors.red:Colors.black,),),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: [

                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(imgurl + widget.pimg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(imgurl + widget.pimg1),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),


                    // //3rd Image of Slider
                    // Container(
                    //   margin: EdgeInsets.all(6.0),
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
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    viewportFraction: 0.8,
                  ),
                ),
                const  SizedBox(height: 5),
                Text(
                  "About",
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
               const SizedBox(height: 2),
                Text(widget.pdescription.toString(),
                  style: grayTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: medium,
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Text(
                      "Package Active :- ",
                      style: blackTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(widget.pactive.toString(),
                      style: grayTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Package Days   :- ",
                      style: blackTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(widget.pdays.toString(),
                      style: grayTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Package Schedule :- ",
                      style: blackTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(widget.pschedule.toString(),
                    style: grayTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: medium,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Seat AC-BUS:- ",
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(widget.pavailableseat_ac.toString(),
                      style: grayTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Seat NoN-AC-BUS:- ",
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(widget.pavailablenonseat_ac.toString(),
                      style: grayTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Text(
                  "Booking Date : ",
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text(
                        "Start Date :- ",
                        style: blackTextStyle.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(widget.pstartdate.toString(),
                        style: grayTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text(
                        "End Date   :- ",
                        style: blackTextStyle.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(widget.penddate.toString(),
                        style: grayTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          (widget.pactive.toString()=="NO")?SizedBox(height: 0,):Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                  width: 4.0,
                ),
              ),
            ),
            child: Column(
              children: [
                CustomButton(
                  text: " Book Now",
                  onPressed: () {
                    Routes.instance
                        .push(widget:  BusDetail(id: widget.pid,) , context: context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
