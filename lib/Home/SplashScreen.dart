import 'dart:async';
import 'package:car_rental/Home/Home.dart';
import 'package:car_rental/Home/onBoardingScreen.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var routing;
  getData() async{
    Constant.sharedPref =  await SharedPreferences.getInstance();
      setState(() {
      routing = Constant.sharedPref!.getBool("Active");
      });
}

  @override
  void initState() {
    getData();
    super.initState();
    Timer(Duration(seconds: 6), route);
  }

  route() {
  routing !=null ?  Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()))
      :
         Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  }

  
  var spinkit = SpinKitThreeBounce(
  color: Colors.green[800],
  size: 25.0,
);

var ss =  SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white60,
        ),
        child: Stack(children: <Widget>[
         Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              Expanded(
                flex: 1,
                child:   Padding(
                 padding: const EdgeInsets.only(top: 0),
                 child: Center(
                   child: Text(
                    'Design and Implementation of Car Rental Mobile App.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoMono(textStyle:
                      TextStyle(
                        color: Constant.kPrimaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                    )),
                 ),
               ),
              ),

              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('img/kadpoly.png', height: 120, width: 150,),
                      YMargin(5),
                      Text(
                        'Kaduna Polytechnic',
                        style: GoogleFonts.robotoMono(textStyle:
                          TextStyle(
                            color: Constant.kPrimaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                        )
                      ),
                    ],
                  ),
                ),   
              ),

              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'CAR RENTAL',
                        style: GoogleFonts.robotoMono(textStyle:
                          TextStyle(
                            color: Constant.kPrimaryColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w800),
                        )
                      ),
                       SizedBox(
                height: 10.0,
              ),
              Container(
                child: spinkit,
              ),
              YMargin(10)
                    ],
                  ),
                ),   
              ),
            
                
            ],
          )
        ]),
      ),
    );
  }
}
