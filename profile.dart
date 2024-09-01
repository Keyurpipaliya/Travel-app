import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/MyTicket.dart';
import 'package:travelingapp/Screen/editprofile.dart';
import 'package:travelingapp/Screen/inquiry.dart';
import 'package:travelingapp/Screen/login.dart';
import 'package:travelingapp/Screen/resetpassword.dart';
import 'package:travelingapp/Screen/save.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/widgets/profile_menu.dart';

import '../constants/theme_google.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var id;
  var name = "";
  var email = "";
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id");
      name = prefs.getString("cname").toString();
      email = prefs.getString("cemail").toString();
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Profile",
          style: whiteTextStyle.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              ProfileMenu(
                  icon: Icons.person_outline,
                  label: "Edit Profile",
                  onTap: () {
                    Routes.instance
                        .push(widget: const EditProfile(), context: context);
                  }),
              ProfileMenu(
                  icon: Icons.airplane_ticket_outlined,
                  label: "My Ticket",
                  onTap: () {
                    Routes.instance
                        .push(widget: const MyTicket(), context: context);
                  }),
              ProfileMenu(
                  icon: Icons.bookmark_border,
                  label: "Bookmark",
                  onTap: () {
                    Routes.instance
                        .push(widget: const SavePage(), context: context);
                  }),
              ProfileMenu(
                  icon: Icons.info_outline_rounded,
                  label: "Inquiry",
                  onTap: () {
                    Routes.instance
                        .push(widget: const Inquiry(), context: context);
                  }),
              ProfileMenu(
                  icon: Icons.lock_open,
                  label: "Change Password",
                  onTap: () {
                    Routes.instance
                        .push(widget: const ResetPassword(), context: context);
                  }),
              ProfileMenu(
                  icon: Icons.power_settings_new,
                  label: "Sign Out",
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Routes.instance.pushAndRemoveUntil(
                        widget: const Login(), context: context);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
