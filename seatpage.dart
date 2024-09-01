import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelingapp/Screen/confirmpage.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class SeatPage extends StatefulWidget {
  var id;
   SeatPage({super.key,this.id});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  Future<List<dynamic>?>? alldata;

  int price = 0;
  var select = false;


  List<String> seatnumber=[];

  int tax = 0;

  Future<List<dynamic>?>? getdata() async {
    print(widget.id);
    Uri uri = Uri.parse(UrlResource.SEAT);
    var respoce = await http.post(
      uri,body: {"id":widget.id});
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

  var name="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Ticket Order",
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
              return
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Padding(
                          padding: EdgeInsets.only(top: 5,left: 10),
                          child: Text(
                            "Select Your \nFavorite Seat",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "Seat\nPrice :- "  ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(right: 10),
                        //   child: Text(
                        //     snapshot.data![index]["seat_price"].toString(),
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.bold
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40,top:20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SizedBox(
                          height: 475,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, mainAxisSpacing: 5, crossAxisSpacing: 5),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return  GestureDetector(
                                    onTap: () {
                                      if((snapshot.data![index]["seat_type"].toString()=="Available"))
                                        {
                                          if(seatnumber.indexOf(snapshot.data![index]["seat_number"].toString())<=-1)
                                            {
                                              seatnumber.add(snapshot.data![index]["seat_number"].toString());
                                              setState(() {
                                                select = true;
                                                var sprice = snapshot.data![index]["seat_price"];
                                                price = price + int.parse(sprice);
                                                tax = tax + 20;
                                                print("price = ${price}");

                                              });
                                            }
                                          else
                                            {

                                              var i = seatnumber.indexOf(snapshot.data![index]["seat_number"].toString());
                                              log("remove " + i.toString() );
                                              setState(() {
                                                seatnumber.removeAt(i);
                                              });
                                              setState(() {
                                                select = true;
                                                var sprice = snapshot.data![index]["seat_price"];
                                                price = price - int.parse(sprice);
                                                tax = tax - 20;
                                                print("price = ${price}");

                                              });
                                            }


                                        }

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primaryColor,
                                          width: 2.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                              color: (snapshot.data![index]["seat_type"].toString()=="Available")
                                              ?(seatnumber.indexOf(snapshot.data![index]["seat_number"].toString())>=0)?Colors.deepPurpleAccent:Colors.deepPurpleAccent.shade100:Colors.grey.shade400,
                                              height: 47.5,
                                              width: 47.5,
                                              child: Center(
                                                  child: Text(
                                                snapshot.data![index]["seat_number"].toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.crop_square_rounded,
                            size: 26,
                            color: primaryColor1,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Available',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.square_rounded,
                            size: 26,
                            color: primaryColor,
                          ),
                          const  SizedBox(width: 8),
                          const  Text(
                            'Selected',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const  SizedBox(width: 12),
                          Icon(
                            Icons.square_rounded,
                            size: 26,
                            color: grayColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Unavailable',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: primaryColor,
                  width: 4.0,
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Selected Seat  :- ",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                           seatnumber.join(",").toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  text: "Pay : " + price.toString(),
                  onPressed: ()async {

                    if(price.toString()!="0")
                      {
                        Uri uri = Uri.parse(UrlResource.SEAT);
                        var respoce = await http.post(
                            uri,body: {"id":widget.id});
                        if (respoce.statusCode == 200) {
                          var body = respoce.body.toString();
                          print(body);
                          var json = jsonDecode(body);
                          // print(json["data"]);
                          // return json["data"];
                          if(json["status"]=="true")
                          {
                            print("object");
                            String cname = json["data"][0]["city_name"].toString();
                            String pname = json["data"][0]["package_title"].toString();
                            String img = json["data"][0]["seat_image"].toString();
                            String type = json["data"][0]["bus_type"].toString();
                            String buid = json["data"][0]["bus_id"].toString();
                            String bno = json["data"][0]["bus_number"].toString();
                            String date = json["data"][0]["sdate"].toString();
                            String time = json["data"][0]["stime"].toString();
                            String address = json["data"][0]["bus_addres"].toString();
                            String sno = seatnumber.join(",").toString();
                            // String pprice = json["data"][0]["seat_price"].toString();
                            print("name = $name");
                            print("price = ${price.toString()}");
                            var total = int.parse(price.toString()) + int.parse(tax.toString());
                            print(total);
                            Routes.instance.push(widget: ConfirmPage(cname: cname,pname: pname,
                              bimg: img,btype: type,bno: bno,bdate: date,btime: time,bid: buid,
                              baddres: address,snumber: sno,sprice: price.toString(),total: total,btax: tax.toString(),), context: context);
                          }
                        } else {
                          print("error");
                        }
                      }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please select atleast one seat"))
                        );
                      }




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
