import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelingapp/Screen/login.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import '../constants/UrlResource.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isShowPassword = true;
  var cityid;
  List<dynamic> cityData = [];
  getdata() async {
    Uri uri = Uri.parse(UrlResource.City);
    var responce = await http.get(uri);
    if (responce.statusCode == 200) {
      var body = jsonDecode(responce.body);
      print(body);
      setState(() {
        cityid = body["data"][0]["city_id"];
        cityData = body['data'];
        print(cityData);
      });
    } else {
      print("api error");
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  // TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
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
                    const SizedBox(height: 20.0),
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
                            .height / 1.5,
                        decoration:
                        BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const  SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "SingUP",
                              style: blackTextStyle.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
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
                              height: 20.0,
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
                              height: 20.0,
                            ),
                            Container(

                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 15,),
                                  cityData.isNotEmpty
                                      ? DropdownButton(
                                    // dropdownColor: Color(0xffa4469c),
                                    hint: Text("Select City"),
                                    // value: city == null || city.isEmpty? cityData[0]:city,
                                    value: cityid,
                                    items: cityData.map((value) {
                                      return DropdownMenuItem<dynamic>(
                                        value: value["city_id"],
                                        child: Text(value['city_name']),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      print("value = ${value}");
                                      setState(() {
                                        cityid = value!;
                                      });
                                    },
                                  )
                                      : Container(),
                                ],
                              ),
                            ),
                            Divider(),
                            const SizedBox(
                              height: 20.0,
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
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              controller: password,
                              obscureText: isShowPassword,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                prefixIcon: const Icon(
                                  Icons.password_sharp,
                                  color: Colors.black,
                                ),
                                suffixIcon: CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      isShowPassword = !isShowPassword;
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  child:  Icon(
                                    isShowPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const  SizedBox(
                              height: 30.0,
                            ),
                            CustomButton(
                              text: "SignUp",
                              onPressed: ()async{

                              var cname = name.text.toString();
                              print(cname);
                              var cphone = phone.text.toString();
                              print(cphone);
                              // var ccity = city.toString();
                              // print(ccity);

                              var cemail = email.text.toString();
                              print(cemail);
                              var cpassword = password.text.toString();
                              print(cpassword);

                              //
                              final bool emailValid =
                              RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(cemail);
                              if (cname == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "Please Enter Name"))
                                );
                              }
                              else if (cphone == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "Please Enter Phone"))
                                );
                              }
                              else if(cphone.length!=10)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "Please Enter Valid No"))
                                  );
                                }
                              else if (cityid == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "Please Select City"))
                                );
                              }
                              else if (cemail == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "Please Enter Valid Email-ID"))
                                );
                              }
                              else if (cpassword == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "Please Enter  Password"))
                                );
                              }
                              else if (!emailValid) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        "Please Enter  Email-ID"))
                                );
                              }
                              else{

                                Uri uri = Uri.parse(UrlResource.REGISTER);
                                var respoce = await http.post(uri,body: {
                                  "name":cname,
                                  "phone":cphone,
                                  "city":cityid,
                                  "email":cemail,
                                  "password":cpassword,

                                });

                                if(respoce.statusCode==200)
                                {
                                  var body = respoce.body.toString();
                                  print(body);
                                  Routes.instance
                                      .pushAndRemoveUntil(widget: const Login(), context: context);
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "Signup error"))
                                  );
                                }
                              }

                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          const  Text("I have already an account ?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              Routes.instance
                                  .push(widget: const Login(), context: context);
                            },
                            child: Text(
                              "Login Account",
                              style: TextStyle(color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ),
    );
  }
}
