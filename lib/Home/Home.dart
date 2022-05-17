import 'package:car_rental/Screen/Admin/adminLogin.dart';
import 'package:car_rental/Screen/Customer/customerLogin.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
        child: SingleChildScrollView(
          child: Container(
            height: screen.height,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.white30,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Car Rental System \n for',
                              style: TextStyle(
                                  color:
                                      Constant.kPrimaryColor.withOpacity(0.8),
                                  fontFamily: 'Raleway',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Center(
                            child: Text(
                              'Global Car Rental Service',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Satisfy',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                  Expanded(
                    flex: 4,
                    child: Image.asset('img/board11.png'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                   
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: FlatButton(
                            color: Constant.kPrimaryColor.withOpacity(0.5),
                            child: Text(
                              'CUSTOMER DASHBOARD',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                            shape: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Constant.kPrimaryColor.withOpacity(0.1),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.all(18.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomerLogin()));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                             Container(
                          width: MediaQuery.of(context).size.width,
                          child: FlatButton(
                            color: Constant.kPrimaryColor.withOpacity(0.5),
                            child: Text(
                              'ADMIN DASHBOARD',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            shape: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Constant.kPrimaryColor.withOpacity(0.1),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.all(18.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminLogin()));
                            },
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
      ),
    );
  }
}
