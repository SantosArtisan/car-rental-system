import 'package:car_rental/Screen/Admin/addCar.dart';
import 'package:car_rental/Screen/Admin/adminProfile.dart';
import 'package:car_rental/Screen/Admin/manageCar.dart';
import 'package:flutter/material.dart';
import 'Home/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'util/constant.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Constant.sharedPref =  await SharedPreferences.getInstance();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/addCar': (BuildContext context) => AddCar(),
        '/adminProfile': (BuildContext context) => AdminProfile(),
        '/manageCar': (BuildContext context) => ManageCar(),
      },
      title: 'Car Rental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Raleway',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
