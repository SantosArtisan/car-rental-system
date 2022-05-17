import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cool_alert/cool_alert.dart';

AppBar loginAppBar({required String title, context}) {
  return AppBar(
    backgroundColor: Constant.kPrimaryColor.withOpacity(0.2),
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: IconButton(
        icon: Icon(
          Icons.close,
          size: 30.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        color: Constant.kPrimaryColor.withOpacity(0.5),
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 18.0,
      ),
    ),
  );
}

AppBar signUpAppBar({required String title, context}) {
  return AppBar(
    backgroundColor: Constant.kPrimaryColor.withOpacity(0.2),
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: IconButton(
        icon: Icon(
          Icons.close,
          size: 30.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        color: Constant.kPrimaryColor.withOpacity(0.5),
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 18.0,
      ),
    ),
  );
}

AppBar addCarAppBar({required String title, context}) {
  return AppBar(
    elevation: 0,
    title: Text(
      'Add Car',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
  );
}

AppBar addAdminAppBar({required String title, context}) {
  return AppBar(
    elevation: 0,
    title: Text(
      'Add Admin',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
  );
}

AppBar registeredUserAppBar({required String title, context}) {
  return AppBar(
    elevation: 0,
    title: Text(
      'Registered User',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
  );
}

AppBar manageBookingAppBar({required String title, context}) {
  return AppBar(
    elevation: 0,
    title: Text(
      'Manage Booking ',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
  );
}

AppBar paymentHistoryAppBar({required String title, context}) {
  return AppBar(
    elevation: 0,
    title: Text(
      'Payment History',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(FontAwesomeIcons.moneyBill),
      ),
    ],
  );
}

AppBar manageCarAppBar({required String title, context}) {
  return AppBar(
    elevation: 0,
    title: Text(
      'Manage Car',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
  );
}

Widget adminMenu(context, String text, String icon, route) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Card(
      child: InkWell(
        highlightColor: Constant.kPrimaryColor.withOpacity(0.3),
        onTap: route,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 50,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'Quando',
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    ),
  );
}


void showInternetError(context) {
    CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          title: 'Oops...',
          text: 'No internet connection!',
          loopAnimation: true,
          backgroundColor: Constant.kPrimaryColor,
        );

  }


void showAmountError(context) {
     CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Oops...',
          text: 'Minimum amount is NGN500',
          loopAnimation: true,
          backgroundColor: Constant.kPrimaryColor,
        );
  }

  void showBitcoinError(context) {
    CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Oops...',
          text: 'Minimum amount is 0.000029',
          loopAnimation: true,
          backgroundColor: Constant.kPrimaryColor,
        );
  }


 void showBitcoinInsufficientError(context) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Oops...',
          text: 'Your balance is not sufficient for this transaction',
          loopAnimation: true,
          backgroundColor: Constant.kPrimaryColor,
        );
  }
  

 void showLoadingDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Row(
            children: <Widget>[
              new CircularProgressIndicator(),
              SizedBox(
                width: 25.0,
              ),
              new Text("Please wait..."),
            ],
          ),
        );
      },
    );
  }
