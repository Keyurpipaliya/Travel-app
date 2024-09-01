import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/login.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import '../constants/UrlResource.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isShowPassword = true;


  TextEditingController opws = TextEditingController();
  TextEditingController npws = TextEditingController();
  TextEditingController cpws = TextEditingController();

  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
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
                      const SizedBox(height: 50.0),
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
                              .height / 1.6,
                          decoration:
                          BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              const  SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "Reset Password",
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
                                validator: (val)
                                {
                                  if(val!.length<=0)
                                    {
                                      return "Please Enter Old Password";
                                    }
                                  return null;
                                },
                                controller: opws,
                                obscureText: isShowPassword,
                                decoration: InputDecoration(
                                  hintText: "Old Password",
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
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                validator: (val)
                                {
                                  if(val!.length<=0)
                                  {
                                    return "Please Enter New Password";
                                  }
                                  return null;
                                },
                                controller: npws,
                                obscureText: isShowPassword,
                                decoration: InputDecoration(
                                  hintText: "New Password",
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
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                validator: (val)
                                {
                                  if(val!.length<=0)
                                  {
                                    return "Please Enter Confirm Password";
                                  }
                                  else
                                    {
                                      return null;
                                    }

                                },
                                controller: cpws,
                                obscureText: isShowPassword,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
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
                                height: 50.0,
                              ),
                              CustomButton(
                                text: "Reset Password",
                                onPressed: ()async{
                                  if(formkey.currentState!.validate())
                                  {
                                    var opaw = opws.text.toString();
                                    print(opaw);
                                    var npaw = npws.text.toString();
                                    print(npaw);
                                    var cpaw = cpws.text.toString();
                                    print(cpaw);

                                    SharedPreferences prefs =await SharedPreferences.getInstance();
                                    var id = prefs.getString("id");
                                    print(id);

                                    Uri uri = Uri.parse(UrlResource.RESETPWS);
                                    var respoce = await http.post(uri,body: {
                                      "opws":opaw,
                                      "npws":npaw,
                                      "uid":id,
                                    });

                                    if(respoce.statusCode==200)
                                    {
                                      var body = respoce.body.toString();
                                      print(body);
                                      
                                      Routes.instance
                                          .pushAndRemoveUntil(widget: const Login(), context: context);
                                    }
                                    else{
                                      print("error");
                                    }
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
      ),
    );
  }
}
