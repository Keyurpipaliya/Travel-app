import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import 'MyTicket.dart';

class ViewTicketPage extends StatefulWidget{
  var cname="";
  var pname;
  var bimg;
  var btype;
  var bookid;
  var bid;
  var bno;
  var bdate;
  var btime;
  var baddres;
  var snumber;
  var sprice;
  var btax;
  var total;
  var seat_list;
  ViewTicketPage({super.key,required this.seat_list,
    required this.cname,this.bookid,this.bid,this.total,this.btax,this.pname,this.bimg,this.btype,this.bno,this.bdate,this.btime,this.baddres,this.snumber,this.sprice
  });

  @override
  State<ViewTicketPage> createState() => _ViewTicketPageState();
}

class _ViewTicketPageState extends State<ViewTicketPage> {
  Future<List<dynamic>?>? alldata;
  var imgurl = UrlResource.busimg;
  //
  // List<dynamic> setnoData = [];
  // Future<List<dynamic>?>? getdata() async {
  //
  //   print(imgurl);
  //   Uri uri = Uri.parse(UrlResource.BOOKSETNO);
  //   var respoce = await http.post(uri,body: {
  //     "bid":bid,
  //     "bkid":bookid,
  //   });
  //   if (respoce.statusCode == 200) {
  //     var body = respoce.body.toString();
  //     print(body);
  //     var json = jsonDecode(body);
  //     print(json["data"]);
  //     setState(() {
  //       setnoData = json["data"];
  //       print("setdata = ${setnoData}");
  //     });
  //   } else {
  //     print("error");
  //   }
  // }
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     alldata = getdata();
  //   });
  // }


  bool isshow=false;

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.parse(UrlResource.BOOKCANCELCHECK);
    var respoce = await http.post(uri,body: {"bid":widget.bookid.toString()});
    if (respoce.statusCode == 200) {
      var body = respoce.body.toString();
      var json = jsonDecode(body);

      if(int.parse(json["date_difference"].toString())<=5)
        {
          setState(() {
            isshow=false;
          });
        }
      else
        {
          setState(() {
            isshow=true;
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
        title: Text(
          "Ticket Detail",
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/bus-image.png"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cname,
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          widget.pname,
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Bus Detail",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const  SizedBox(height: 10),
              Container(
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
                                image: NetworkImage(imgurl + widget.bimg),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 135),
                                child: Text(
                                  widget.btype,
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
                                    widget.bno,
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
                                    widget.cname,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Container(
                                    width: 30,
                                    height: 2,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    widget.pname,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: medium,
                                    ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        widget.bdate,
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
                                        widget.btime,
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
                                        widget.baddres,
                                        style: grayTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Price Detail",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 110,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Seat Number",
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          Expanded(
                            child: Text(
                             widget.seat_list,
                              style: blackTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      // const  SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Passenger",
                      //       style: blackTextStyle.copyWith(
                      //         fontSize: 18,
                      //         fontWeight: medium,
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Text(
                      //         widget.sprice,
                      //         style: blackTextStyle.copyWith(
                      //           fontSize: 16,
                      //           fontWeight: medium,
                      //         ),
                      //         textAlign: TextAlign.end,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Tex",
                      //       style: blackTextStyle.copyWith(
                      //         fontSize: 18,
                      //         fontWeight: medium,
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Text(
                      //         widget.bookid,
                      //         style: blackTextStyle.copyWith(
                      //           fontSize: 16,
                      //           fontWeight: medium,
                      //         ),
                      //         textAlign: TextAlign.end,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "Total",
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Rs "+widget.sprice,
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomButton(
                text: "Cancel",
                onPressed: () async{
                  if(isshow)
                    {
                      Uri uri = Uri.parse(UrlResource.CANCELBOOKING);
                      var respoce = await http.post(uri,body: {"bid":widget.bookid.toString()});
                      if (respoce.statusCode == 200) {
                        var body = respoce.body.toString();
                       // var json = jsonDecode(body);


                        Navigator.of(context).pop();

                        Navigator.of(context).pop();

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (conetxt)=>MyTicket())
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                "Ticket Cancel Successfully"))
                        );

                      } else {
                        print("error");
                      }
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                              "You can not cancel the ticket now"))
                      );
                    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}