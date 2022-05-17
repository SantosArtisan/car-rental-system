import 'package:car_rental/Screen/Customer/customerDashboard.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:car_rental/Widget/user_widget.dart';

class Success extends StatefulWidget {
  const Success({ Key? key, this.period, this.borrowAmount, this.ref, this.car}) : super(key: key);
  final period;
  final borrowAmount;
  final car;
  final ref;
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: singleAppBar(title: 'Success', context: context,),
      body: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 5.0),
              child: Icon(Icons.check_circle, size: 140, color: Constant.kPrimaryColor,),
            ),

            Text(
                        'Transaction was successful',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoMono(textStyle:
                          TextStyle(
                            color: Constant.kPrimaryColor.withOpacity(0.6),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800),
                            
                        )
                      ),

                      Divider(),

             Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
              child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                              'Transaction ref',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(1.0)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                          
                             Text(
                              '${widget.ref}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
           
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                              'You borrowed',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(1.0)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                          
                             Text(
                              ' ${widget.car}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),

           

            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                              'Borrowed for ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                          
                             Text(
                             widget.period.toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),

             Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                              'Amount paid',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                          
                             Text(
                              'NGN ${widget.borrowAmount}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 30.0),
              child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                              'Transaction Date',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                          
                             Text(
                              '${DateFormat.yMMMd().format(DateTime.now())}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoMono(textStyle:
                                TextStyle(
                                  color: Constant.kPrimaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                                  
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),


             Padding(
               padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
               // ignore: deprecated_member_use
               child: FlatButton(
                  color: Constant.kPrimaryColor,
                  child: Text(
                      'DASHBOARD',
                      style: TextStyle(fontSize: 14),
                  ),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(3.0),
                  ),
                  padding: EdgeInsets.all(18),
                  textColor: Colors.white,
                  onPressed: () {
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomerDashboard()));
                  },
                ),
             ),
                    
          ],
          ),
        ),
    );
  }

  AppBar singleAppBar({String? title, context}) {
  return AppBar(
    backgroundColor: Constant.kPrimaryColor,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
         Icons.arrow_back_ios,
         color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      color: Constant.kPrimaryColor.withOpacity(0.5),
    ),
    title: Text(
      title!,
      style: TextStyle(
        fontFamily: " ",
        color: Colors.white,
        fontSize: 18.0
      ),
      ),
  );
}
}