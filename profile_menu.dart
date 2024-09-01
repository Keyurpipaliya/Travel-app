import 'package:flutter/material.dart';
import 'package:travelingapp/constants/theme_google.dart';

class ProfileMenu extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onTap;

  const ProfileMenu({super.key,
    required this.icon,
    required this.label,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.yellow,
                  size: 20,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(label,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}