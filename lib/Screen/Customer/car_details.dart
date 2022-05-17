import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:car_rental/Screen/Customer/success.dart';
import 'package:car_rental/Widget/user_widget.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';



bool? isLoading = false;
class CarDetails extends StatefulWidget {
  CarDetails({this.data});
  final List? data;
  @override 
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {


void _showDialog() {
    // flutter defined function
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


final formKey = new GlobalKey<FormState>();
  Random random = new Random();
  final TextEditingController hoursController = new TextEditingController();
   

 bool isLoading = false;
  var result;
  int? amountPayable;
  int? orderID;
  String? refID;
  String? period;
  DateTime now = new DateTime.now();
  DateTime date = new DateTime( DateTime.now().year, DateTime.now().month, DateTime.now().day);




  var publicKey = 'pk_test_900f6286d49dd3d323d4b8e4530501fd060356d6';
  final plugin = PaystackPlugin();

  String _getReference() {
    return '${DateTime.now().millisecondsSinceEpoch}';
  }
  
  _initiatePayment() async{
    Charge charge = Charge()
       ..amount = amountPayable!  * 100
       ..reference =  refID
        // or ..accessCode = _getAccessCodeFrmInitialization()
       ..email = userEmail.toString();
        CheckoutResponse response = await plugin.checkout(
          context,
          method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
          charge: charge,
        );

        if (response.status) {
          _updateUserTransaction(refID, orderID);
        }
  }

  
    _confirmOrder(context, noOfHours, amount) async{
          result = await Connectivity().checkConnectivity();
          if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
                  setState(() {
                        isLoading = true;
                      });
                      isLoading
                          ? showLoadingDialog(context)
                          : Navigator.of(context, rootNavigator: true).pop('dialog');
                      Timer(Duration(seconds: 3), () {
                         setState(() {
                          isLoading = false;
                        });
                        !isLoading
                            ? Navigator.of(context, rootNavigator: true).pop('dialog')
                            : showLoadingDialog(context);
                        //CallBackFunction Here
                        _initiateUserTransaction(noOfHours, amount);
                       
                      });
                       //Success Page Call Here
            }else{
                showInternetError(context);
            }
  }

  _initiateUserTransaction(noOfHours, amount) async {
          final response =
            await http.post(Uri.parse('https://saniabdullahi.com.ng/result.php'), body: {
            "request": "INITIATE TRANSACTION",
            "user": userID.toString(),
            "car": widget.data![0]["car_id"].toString(),
            "period":  noOfHours.toString(),
            "borrow_date": date.toString(), 
            "orderID": orderID.toString(),
            "amount": amount.toString()
      });

      if (response.statusCode == 200) {
        print(response.body.toString());
          _initiatePayment();
      } 
      
     
  }


  _updateUserTransaction(refID, orderID) async {
          final response =
            await http.post(Uri.parse('https://saniabdullahi.com.ng/result.php'), body: {
            "request": "UPDATE TRANSACTION",
            "user": userID.toString(), 
            "ref": refID.toString(),
            "car": widget.data![0]["car_id"].toString(),
            "orderID": orderID.toString()
      });

      if (response.statusCode == 200) {
        print(response.body.toString());
         Navigator.push(context, MaterialPageRoute(builder: (context) => Success(borrowAmount: amountPayable , period:  period.toString(), ref: refID, car: widget.data![0]["brand"],)));
      }
      
     
  }

 
getData() {
      setState(() {
      userID = Constant.sharedPref!.getString("user");
      userEmail = Constant.sharedPref!.getString("email");
      });
}


@override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    getData();
    orderID = random.nextInt(1000000000);
    refID = _getReference();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          color: Constant.kPrimaryColor.withOpacity(0.03),
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
           children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    height: MediaQuery.of(context).size.height/2.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                    color: Constant.kPrimaryColor.withOpacity(0.8),
                     image: DecorationImage(image: NetworkImage('https://saniabdullahi.com.ng/user_uploads/${widget.data![0]["picture"].toString()}'),fit: BoxFit.fill,)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end, 
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Center(
                            child: Text(
                              widget.data![0]["name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quando',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700),
                    ),
                          ),
                        ),
                    
                      ],
                    ),
                ),
                SizedBox(height: 20,),
                tile(
                context,
                FontAwesomeIcons.car,
               
                "Brand: ",
               widget.data![0]["brand"],
                1,
                (){
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AnnouncementView(data: postList.where((element) => element['announcement_id'] == postList[index]['announcement_id']).toList(),)));
                }
              ),
              
               tile(
                context,
                Icons.workspaces_rounded,
                "Model: ",
               widget.data![0]["model"],
                1,
                (){
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AnnouncementView(data: postList.where((element) => element['announcement_id'] == postList[index]['announcement_id']).toList(),)));
                }
              ),

               tile(
                context,
                Icons.color_lens,
                "Color: ",
               widget.data![0]["color"],
                1,
                (){
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AnnouncementView(data: postList.where((element) => element['announcement_id'] == postList[index]['announcement_id']).toList(),)));
                }
              ),

               tile(
                context,
                Icons.money,
                "Price: ",
               widget.data![0]["price"],
                1,
                (){
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AnnouncementView(data: postList.where((element) => element['announcement_id'] == postList[index]['announcement_id']).toList(),)));
                }
              ),

               tile(
                context,
                Icons.check_circle,
                "Car Status: ",
               widget.data![0]["IsBorrowed"] == "1" ? "Unavailable" : "Available",
                1,
                (){
                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AnnouncementView(data: postList.where((element) => element['announcement_id'] == postList[index]['announcement_id']).toList(),)));
                }
              ),
              SizedBox(height: 20,),
              widget.data![0]["IsBorrowed"] == '0'
              ? 
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: FlatButton(
                    color: Constant.kPrimaryColor.withOpacity(0.8),
                    child: Text(
                        'BORROW CAR',
                        style: TextStyle(fontSize: 14),
                    ),
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(18),
                    textColor: Colors.white,
                    onPressed: () {
                        showInputDialog(context);
                    },
                  ),
              )
              :
               Container(),

              YMargin(15.0),
           ], 
          ),
        ),
      ),
    );
  }
   showInputDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              Center( child: new Text("Enter number of hours", style: TextStyle(fontSize: 14),)),
              YMargin(10),
              TextFormField(
                style: TextStyle(
                    fontSize: 16, color: Colors.black54),
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Number of Hours',
                  hintStyle: TextStyle(fontSize: 14),
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey[300]!,
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey[300]!,
                  )),
                  suffix: Icon(Icons.money,),
                ),
                controller: hoursController,
              ),
              YMargin(15),
               Padding(
                 padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                 // ignore: deprecated_member_use
                 child: FlatButton(
                    color: Constant.kPrimaryColor.withOpacity(0.7),
                    child: Text(
                        'PROCEED',
                        style: TextStyle(fontSize: 14),
                    ),
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(3.0),
                    ),
                    padding: EdgeInsets.all(15),
                    textColor: Colors.white,
                    onPressed: () {
                      var noOfHours = hoursController.text;
                        int amountPay = int.parse(noOfHours) * int.parse(widget.data![0]["price"]) ;
                        setState(() {
                        isLoading = true;
                        period = noOfHours;   
                        amountPayable = amountPay;
                      });
                      print(amountPay);
                      isLoading
                          ? showLoadingDialog(context)
                          : Navigator.of(context, rootNavigator: true).pop('dialog');
                          _confirmOrder(context, noOfHours, amountPayable);
                    },
                  ),
               ),
            ],
          ),
        );
      },
    );
  }
}



tile(context, IconData icon, String char, String heading, int id, Function() route){
  return Column(

                    children: [
                      Container(
                        // color: Color(0Xffffffff),
                        width: MediaQuery.of(context).size.width,

                        child: Card(
                          child: InkWell(
                            highlightColor: Constant.kPrimaryColor.withOpacity(0.2),
                                            onTap: route,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                                                        child:  Icon(icon, size: 30.0, color: Constant.kPrimaryColor.withOpacity(0.8),)
                                                      ),
                                                      SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top:20.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  char,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    fontSize: 12.0,
                                                                    fontFamily: 'Quando',
                                                                    color: Colors.black54,
                                                                    fontWeight: FontWeight.w600
                                                                  ),
                                                                  
                                                                ),
                                                                 Text(
                                                                  heading,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    fontSize: 14.0,
                                                                    fontFamily: 'Quando',
                                                                    color: Colors.black54,
                                                                    fontWeight: FontWeight.w500
                                                                  ),
                                                                  
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox( height: 25.0,),
                                                            
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                   
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  
                                              ],
                                            ),
                                                ),
                                           
                                              ],
                                            ),
                                          ),
                        ),
                      ),
                      SizedBox(height: 0.0,),
                    ],
                  );

}
