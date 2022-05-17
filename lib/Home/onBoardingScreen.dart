import 'package:car_rental/Home/Home.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageDecoration = PageDecoration(
    titleTextStyle: PageDecoration()
        .titleTextStyle
        .copyWith(color: Colors.black, fontSize: 20.0, fontFamily: 'Raleway'),
    bodyTextStyle: PageDecoration()
        .bodyTextStyle
        .copyWith(color: Colors.black, fontSize: 16.0, fontFamily: 'Raleway'),
    descriptionPadding: EdgeInsets.all(16.0).copyWith(bottom: 0.0),
    pageColor: Colors.white,
  );
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: buildImage('img/board1.jpg'),
          title: "Welcome to Global Car Rental Service",
          body:
              "Our company rents automobiles for short periods of time for a fee",
          decoration: pageDecoration),
      PageViewModel(
          image: buildImage('img/board11.png'),
          title: "Customer Satisfaction",
          body:
              "Our customers satisfaction is our topmost piority in Global car rental service",
          decoration: pageDecoration),
      PageViewModel(
          image: buildImage('img/board.jpg'),
          title: "Fact About US",
          body:
              "Try us today and you will never regret it, we are the largest car rental company in Africa ",
          decoration: pageDecoration),
      PageViewModel(
        image: buildImage('img/board (4).jpg'),
        title: "What we do",
        body:
            "Our company rents automobiles for short periods of time for a fee, we have different brands and kind of cars in pur garage",
        decoration: pageDecoration,
        // footer: RaisedButton(
        //   onPressed: () => goToHome(context),
        //   color: Theme.of(context).primaryColor,
        //   shape: StadiumBorder(),
        //   child: Text(
        //     'GET STARTED',
        //     style: TextStyle(fontSize: 16.0, color: Colors.white),
        //   ),
        // )
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        done: Text(
          'Done',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onDone: () async{
          Constant.sharedPref = await SharedPreferences.getInstance();
         setState(() {
          Constant.sharedPref?.setBool("Active", true);
        });
          goToHome(context);
        },
        showSkipButton: true,
        skip: Text('Skip'),
        next: Icon(Icons.arrow_forward),
        dotsDecorator: getDotDecorator(),
        skipFlex: 0,
        nextFlex: 0,
        showNextButton: true,
      ),
    );
  }

  Widget buildImage(String path) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 180.0),
          child: Image.asset(path),
        ),
      );

  void goToHome(context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));

  DotsDecorator getDotDecorator() => DotsDecorator(
        color: Color(0XFFBDBDBD),
      );
}
