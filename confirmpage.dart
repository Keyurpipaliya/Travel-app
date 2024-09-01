import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelingapp/Screen/custom_ber.dart';
import 'package:travelingapp/constants/UrlResource.dart';
import 'package:travelingapp/constants/routes.dart';
import 'package:travelingapp/constants/theme_google.dart';
import 'package:travelingapp/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class ConfirmPage extends StatefulWidget{
  var cname="";
  var pname;
  var bimg;
  var btype;
  var bid;
  var bno;
  var bdate;
  var btime;
  var baddres;
  var snumber;
  var sprice;
  var btax;
  var total;
   ConfirmPage({super.key,required this.cname,this.bid,this.total,this.btax,this.pname,this.bimg,this.btype,this.bno,this.bdate,this.btime,this.baddres,this.snumber,this.sprice});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {

  var imgurl = UrlResource.busimg;

  final _razorpay = Razorpay();

  var email,contact,uid;

  getdata()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     email = prefs.getString("cemail").toString();
     contact = prefs.getString("ccontact").toString();
     uid = prefs.getString("id").toString();
   });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getdata();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  void _handlePaymentSuccess(PaymentSuccessResponse payresponse) async {
    // Do something when payment succeeds

    print("cid = ${uid}");
    print("pay = ${widget.total.toString()}");
    print("tid = ${payresponse.paymentId}");

    Uri uri = Uri.parse(UrlResource.BOOKING);
    var respoce = await http.post(uri,body: {
      "cid":uid,
      "bid":widget.bid.toString(),
      "pay":widget.total.toString(),
      "tid":payresponse.paymentId.toString(),
      "seats":widget.snumber.toString(),
      // "bdate":"bdate",
      "bstatus":"Confirm",
    });


    if(respoce.statusCode==200)
    {
      var body = respoce.body.toString();
      print(body);
      Routes.instance
          .pushAndRemoveUntil(widget:  BottomBar(), context: context);
    }
    else{
      print("error");
    }

    print("payment success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("wallet error");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Ticket Confirmation",
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      Text(
                        widget.pname,
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
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
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 135),
                                child: Text(widget.btype,
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
                                  Text(widget.bno,
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
                                  Text(widget.cname,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    width: 40,
                                    height: 2,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(widget.pname,
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
                                      Text(widget.bdate,
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
                                      Text(widget.btime,
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
                                      Text(widget.baddres,
                                        style: grayTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Bus Facilities",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 90,
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
                            "Insurance",
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "YES",
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            "Refundable",
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "YES",
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                height: 172,
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
                              widget.snumber.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const  SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "Passenger",
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.sprice,
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "Tax",
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.btax,
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
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
                              "Rs "+widget.total.toString(),
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
            ],
          ),
        ),
      ),

      bottomNavigationBar: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration:  BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: primaryColor,
                  width: 4.0,
                ),
              ),
            ),
            child: Column(
              children: [
                CustomButton(
                  text: "Pay Now : " + widget.total.toString(),
                  onPressed: () {

                    var options = {
                      'key': 'rzp_test_hdkvBuBbG18tVE',
                      'amount': widget.total * 100,
                      'name': 'Travel Gura',
                      'description': 'On-line Ticket Booking App',
                      'prefill': {
                        'contact': contact,
                        'email': email,
                      }
                    };
                    _razorpay.open(options);
                    // Routes.instance
                    //     .pushAndRemoveUntil(widget: const RootScreen(), context: context);
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