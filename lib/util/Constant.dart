import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constant {
  static SharedPreferences? sharedPref;
  static const kTextColor = Color(0XFF1E2432);
  static const kMediumTextColor = Color(0XFF53627C);
  static const kLightColor = Color(0XFFACB1C0);
  static const kPrimaryColor = Color(0XFF003049);
  static const kBackgroundColor = Color(0XFFFCFCFC);
}

class XMargin extends StatelessWidget {
  final double x;
  const XMargin(this.x);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x);
  }
}

class YMargin extends StatelessWidget {
  final double y;
  const YMargin(this.y);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y);
  }
}

double screenHeight(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.height * percent;

  double screenWidth(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.width * percent;  

     String? userID;
     String? userEmail;