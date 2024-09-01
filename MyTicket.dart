import 'package:flutter/material.dart';
import 'package:travelingapp/Screen/cancel.dart';
import 'package:travelingapp/Screen/ticketpage.dart';

import 'inactiveticketpage.dart';

class MyTicket extends StatefulWidget {
  const MyTicket({super.key});

  @override
  State<MyTicket> createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Ticket"),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Active"),
              ),
              Tab(
                child: Text("Complete"),
              ),
              Tab(
                child: Text("Cancel"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TicketPage(),
            InactiveTicketPage(),
            CancelTicketPage(),
          ],
        ),
      ),
    );
  }
}
