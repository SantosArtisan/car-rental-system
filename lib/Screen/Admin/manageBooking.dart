import 'package:car_rental/Widget/user_widget.dart';
import 'package:flutter/material.dart';

class ManageBooking extends StatefulWidget {
  const ManageBooking({Key? key}) : super(key: key);

  @override
  _ManageBookingState createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: manageBookingAppBar(title: '', context: context),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      ),
    );
  }
}
