import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';

import 'pakagedetails.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  Future<List<dynamic>?>? alldata;
  String _searchTerm = '';
  TextEditingController _search = TextEditingController();
  var imgurl = UrlResource.packimg;

  Future<List<dynamic>?>? getdata() async {
    // Your existing code to fetch data
    Uri uri = Uri.parse(UrlResource.PKG);
    var respoce = await http.post(uri);
    if (respoce.statusCode == 200) {
      var body = respoce.body.toString();
      print(body);
      var json = jsonDecode(body);
      // print(json["data"]);
      return json["data"];
    } else {
      print("err");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  List<dynamic>? _filteredData(List<dynamic>? data) {
    if (data == null || data.isEmpty || _searchTerm.isEmpty) {
      return data;
    }
    return data.where((item) {
      return item["package_title"].toString().toLowerCase().contains(_searchTerm.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: TextFormField(
              controller: _search,
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search Places',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: alldata,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length <= 0) {
                    return Center(
                      child: Text("No Data"),
                    );
                  } else {
                    final filteredData = _filteredData(snapshot.data);
                    if (filteredData!.isEmpty) {
                      return Center(
                        child: Text("No matching data"),
                      );
                    }
                    return ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Routes.instance.push(
                                widget: pakagedetails(
                                    pid: snapshot.data![index]["package_id"]
                                        .toString(),
                                    pname: snapshot.data![index]
                                    ["package_title"]
                                        .toString(),
                                    pimg: snapshot.data![index]
                                    ["package_image"]
                                        .toString(),
                                    pimg1: snapshot.data![index]
                                    ["package_image1"]
                                        .toString(),
                                    pvideo: snapshot.data![index]
                                    ["package_video"]
                                        .toString(),
                                    pdescription: snapshot.data![index]
                                    ["package_description"]
                                        .toString(),
                                    padddatetime: snapshot.data![index]
                                    ["package_datetime"]
                                        .toString(),
                                    pschedule: snapshot.data![index]
                                    ["package_schedule"]
                                        .toString(),
                                    pdays: snapshot.data![index]
                                    ["package_days"]
                                        .toString(),
                                    pactive: snapshot.data![index]
                                    ["package_active"]
                                        .toString(),
                                    pavailableseat_ac: snapshot.data![index]
                                    ["total_seat_ac"]
                                        .toString(),
                                    pavailablenonseat_ac: snapshot.data![index]
                                    ["total_seat_non_ac"]
                                        .toString(),
                                    pstartdate: snapshot.data![index]
                                    ["start_date"]
                                        .toString(),
                                    penddate: snapshot.data![index]
                                    ["end_date"]
                                        .toString()),
                                context: context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(defaultRadius),
                                color: Colors.grey.shade200,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(defaultRadius),
                                      image: DecorationImage(
                                        image: NetworkImage(imgurl +
                                            filteredData[index]["package_image"].toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredData[index]["package_title"].toString(),
                                          style: blackTextStyle.copyWith(
                                            fontSize: 18,
                                            fontWeight: medium,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
