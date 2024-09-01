import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/custom_ber.dart';
import 'package:travelingapp/Screen/home.dart';
import 'package:travelingapp/Screen/login.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import '../constants/UrlResource.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {



  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

var id;
  getdata()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id");
      name.text = prefs.getString("cname").toString();
      phone.text = prefs.getString("ccontact").toString();
      email.text = prefs.getString("cemail").toString();
    });

  }

  @override
  void initState() {
    super.initState();
    getdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.5,
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
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 3),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Center(
                        child: Image.network(
                          "https://www.pngmart.com/files/17/Travel-Icon-Transparent-PNG.png",
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2.0,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(height: 60.0),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 1.8,
                        decoration:
                        BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const  SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Edit Profile",
                              style: blackTextStyle.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: name,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: phone,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: "Phone",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                prefixIcon: Icon(
                                  Icons.phone_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "E-mail",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const  SizedBox(
                              height: 50.0,
                            ),
                            CustomButton(
                              text: "Edit Profile",
                              onPressed: ()async{

                                var cname = name.text.toString();
                                print(cname);
                                var cphone = phone.text.toString();
                                print(cphone);
                                var cemail = email.text.toString();
                                print(cemail);


                                Uri uri = Uri.parse(UrlResource.EDITPROFILE);
                                var respoce = await http.post(uri,body: {
                                  "name":cname,
                                  "phone":cphone,
                                  "email":cemail,
                                  "id":id,
                                });

                                if(respoce.statusCode==200)
                                {
                                  var body = respoce.body.toString();
                                  print(body);
                                  Routes.instance
                                      .pushAndRemoveUntil(widget:  Login(), context: context);
                                }
                                else{
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
