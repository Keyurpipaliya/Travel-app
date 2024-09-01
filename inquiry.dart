import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/custom_ber.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import '../constants/UrlResource.dart';

class Inquiry extends StatefulWidget {
  const Inquiry({super.key});

  @override
  State<Inquiry> createState() => _InquiryState();
}

class _InquiryState extends State<Inquiry> {
  var pakage;
  List<dynamic> pakageData = [];
  getpakagedata() async {
    Uri uri = Uri.parse(UrlResource.PACKAGE);
    var responce = await http.get(uri);
    if (responce.statusCode == 200) {
      var body = jsonDecode(responce.body);
      print(body);
      setState(() {
        pakageData = body['data'];
        print(pakageData);
      });
    } else {
      print("api error");
    }
  }

  TextEditingController text = TextEditingController();


  var id;
  var name;
  var phone;
  var email;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id");
      name = prefs.getString("cname").toString();
      phone = prefs.getString("ccontact").toString();
      email = prefs.getString("cemail").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
    getpakagedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF5C40CC),
                      Color(0xFF5C40CC),
                    ],
                  ))),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Center(
                        child: Image.network(
                      "https://www.pngmart.com/files/17/Travel-Icon-Transparent-PNG.png",
                      width: MediaQuery.of(context).size.width / 2.0,
                      fit: BoxFit.cover,
                    )),
                    const SizedBox(height: 60.0),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Inquiry",
                              style: blackTextStyle.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  pakageData.isNotEmpty
                                      ? DropdownButton(
                                          // dropdownColor: Color(0xffa4469c),
                                          hint: Text("Select package"),
                                          // value: city == null || city.isEmpty? cityData[0]:city,
                                          value: pakage,
                                          items: pakageData.map((value) {
                                            return DropdownMenuItem<dynamic>(
                                              value: value,
                                              child:
                                                  Text(value['package_title']),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            print("value = ${value}");
                                            setState(() {
                                              pakage = value!;
                                              print(pakage);
                                            });
                                          },
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: text,
                              decoration: const InputDecoration(
                                labelText: 'Enter your Inquiry',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            CustomButton(
                              text: "Submit",
                              onPressed: () async {

                                var txt = text.text.toString();
                                print(text);

                                var pakageid;
                                if(pakage == null)
                                {
                                  setState(() {
                                    pakageid = pakage['package_id'].toString();
                                  });
                                }else{
                                  setState(() {
                                    pakageid =pakageData[0]['package_id'].toString();
                                  });
                                }
                                print("pakage = ${pakageid}");
                                Uri uri = Uri.parse(UrlResource.INQUIRY);
                                var respoce = await http.post(uri, body: {
                                  "iname": name,
                                  "iphone": phone,
                                  "iemail": email,
                                  "itext":txt,
                                  "pak": pakageid,
                                });

                                if (respoce.statusCode == 200) {
                                  var body = respoce.body.toString();
                                  print(body);
                                  Routes.instance.pushAndRemoveUntil(
                                      widget: BottomBar(), context: context);
                                } else {
                                  print("error");
                                }
                              },
                            ),
                          ],
                        ),
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
  }
}
