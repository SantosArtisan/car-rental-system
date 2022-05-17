import 'package:car_rental/Home/Home.dart';
import 'package:car_rental/Screen/Admin/addAdmin.dart';
import 'package:car_rental/Screen/Admin/addCar.dart';
import 'package:car_rental/Screen/Admin/adminProfile.dart';
import 'package:car_rental/Screen/Admin/booking_report.dart';
import 'package:car_rental/Screen/Admin/manageCar.dart';
import 'package:car_rental/Screen/Admin/manage_car.dart';
import 'package:car_rental/Screen/Admin/paymentHistory.dart';
import 'package:car_rental/Screen/Admin/registeredUser.dart';
import 'package:car_rental/Screen/Admin/user_report.dart';
import 'package:car_rental/Widget/user_widget.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Sani Abdullahi,',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Quando',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Raleway',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                        Constant.sharedPref!.clear();
                             Constant.sharedPref!.commit();
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('img/user-icon.jpg'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              // Container(
              //   child: SizedBox(
              //       height: 150.0,
              //       width: MediaQuery.of(context).size.width,
              //       child: Carousel(
              //         images: [
              //           ExactAssetImage("img/car2.png"),
              //           ExactAssetImage("img/car1.png"),
              //           ExactAssetImage("img/car3.png"),
              //           ExactAssetImage("img/car4.png"),
              //         ],
              //         boxFit: BoxFit.cover,
              //         dotBgColor: Colors.transparent,
              //       )),
              // ),
              SizedBox(
                height: 40.0,
              ),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(0.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                shrinkWrap: true,
                children: [
                 
                  adminMenu(context, 'Add Car', 'img/car1.png', () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCar()));
                  }),
                  adminMenu(context, 'Manage Car', 'img/car2.png', () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CarData()));
                  }),
 
                  adminMenu(context, 'Registered User', 'img/user-p.png', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserData()));
                  }),
                   adminMenu(context, 'Manage Booking', 'img/money.png', () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BorrowData()));
                  }),
                
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
