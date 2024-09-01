import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/custom_ber.dart';
import 'package:travelingapp/Screen/forgotpassword.dart';
import 'package:travelingapp/Screen/home.dart';
import 'package:travelingapp/Screen/signup.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isShowPassword = true;


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                   const SizedBox(height: 20),
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
                            .height / 2.0,
                        decoration:
                        BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const  SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Login",
                              style: blackTextStyle.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                            const SizedBox(
                              height: 30.0,
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
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 95),
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: (){
                                        Routes.instance
                                            .push(widget: const ForgotPassword(), context: context);
                                      },
                                      child: const Text(
                                          "Forgot Password ?",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                            const  SizedBox(
                              height: 35.0,
                            ),
                            CustomButton(
                              text: "Login",
                              onPressed: () async {
                                var cemail = email.text.toString();
                                print(cemail);
                                var cpassword = password.text.toString();
                                print(cpassword);

                                final bool emailValid =
                                RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(cemail);
                                if (cemail == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "Please enetr username"))
                                  );
                                }
                                else if (cpassword == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "Please enter password"))
                                  );
                                }
                                else if (!emailValid) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "Please enter valid email"))
                                  );
                                }
                                else {
                                  Uri uri = Uri.parse(UrlResource.LOGIN);
                                  var respoce = await http.post(uri, body: {
                                    "email": cemail,
                                    "pws": cpassword
                                  });
                                  if (respoce.statusCode == 200) {
                                    // print("test");
                                    var body = respoce.body.toString();
                                    print(body);
                                    var json = jsonDecode(body);
                                    // print(json["data"]);
                                    if (json["status"] == "true") {
                                      print("object");
                                      var msg = json["message"].toString();
                                      print(msg);

                                      var cid = json["data"]["customer_id"]
                                          .toString();
                                      var cityid = json["data"]["city_id"]
                                          .toString();
                                      var cname = json["data"]["customer_name"]
                                          .toString();
                                      var cemail = json["data"]["customer_email"]
                                          .toString();
                                      var ccontact = json["data"]["customer_contact"]
                                          .toString();

                                      print(cid);
                                      print(cname);
                                      print(ccontact);
                                      print(cemail);

                                      SharedPreferences prefs = await SharedPreferences
                                          .getInstance();
                                      prefs.setString("id", cid).toString();
                                      prefs.setString("cname", cname)
                                          .toString();
                                      prefs.setString("cityid", cityid)
                                          .toString();
                                      prefs.setString("cemail", cemail)
                                          .toString();
                                      prefs.setString("ccontact", ccontact)
                                          .toString();
                                      prefs.setString("islogin", "yes");


                                      Routes.instance
                                          .pushAndRemoveUntil(
                                          widget: BottomBar(),
                                          context: context);
                                    }
                                    else {
                                      var msg = json["message"].toString();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(content: Text(msg))
                                      );
                                    }
                                  }
                                }
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          const  Text("Don't have account ?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              Routes.instance
                                  .push(widget: const SignUp(), context: context);
                            },
                            child: Text(
                              "Create account",
                              style: TextStyle(color: Theme.of(context).primaryColor,
                                fontSize: 15,
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
