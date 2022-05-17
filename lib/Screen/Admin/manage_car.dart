import 'dart:async';
import 'dart:convert';
import 'package:car_rental/Screen/Admin/admin_car_details.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;





class CarData extends StatefulWidget {
  // GetCourseList({this.selectedSemester, this.selectedClass, this.request});
  // final selectedSemester;
  // final String selectedClass;
  // final String request;
  @override
  _CarDataState createState() => _CarDataState();
}

class _CarDataState extends State<CarData> {


  List carData =[];
List carList = [];
List carCount = [];


 var spinkit = SpinKitThreeBounce(
  color: Constant.kPrimaryColor.withOpacity(0.8),
  size: 30.0,
);

 Future<List> _fetchUserData() async {
        final response =
        await http.post(Uri.parse("https://saniabdullahi.com.ng/result.php"), body: {
        "request": "FETCH ALL CARS",

          });
        
        var convertDateToJson = jsonDecode(response.body);
        setState(() {
        carData = convertDateToJson;
      });
      return carData;
      }


@override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserData(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
      var myData = (snapshot.data);
        if (myData == null) {
          return Scaffold( 
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                child: spinkit,
              ),
              SizedBox(height: 10,),
                Center(
                  child: Text( 
                    'Loading...'
                  ),
                ),
              ],
            ),
          );
        } else {
          return myData != null 
          ? 
          CarReport() 
          : 
          Scaffold( 
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                child: Icon(Icons.warning, size: 50, color: Colors.orange[400]),
              ),
              SizedBox(height: 15,),
                Center(
                  child: Text( 
                    'No Registered Agent'
                  ),
                ),
              ],
            ),
             floatingActionButton: FloatingActionButton(
        onPressed: (){
            // Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => AddAgent()));
        },
        child: Icon(Icons.add),
        elevation: 4,
      ),
          );
        }
      },
    );
  }
}











class CarReport extends StatefulWidget {

  @override
  _CarReportState createState() => _CarReportState();
}

class _CarReportState extends State<CarReport> {

final formKey = new GlobalKey<FormState>();
TextEditingController searchController = new TextEditingController(); 

List carData =[];
List carList = [];
List carCount = [];
String? search;

  Future<String> _fetchUserData() async {
        final response =
        await http.post(Uri.parse("https://saniabdullahi.com.ng/result.php"), body: {
        "request": "FETCH ALL CARS",
          });
        
        var convertDateToJson = jsonDecode(response.body);
        setState(() {
        carList = convertDateToJson;
      });
      return "Success";
      }



        Future<List> _countUserList() async {

        final response =
            await http.post(Uri.parse('https://saniabdullahi.com.ng/result.php'), body: {
          "request": "COUNT CARS",
    });

      var convertDataToJson = jsonDecode(response.body);
      setState(() {
        carCount= convertDataToJson;
      });
      return carCount;
  }

 


@override
  void initState() {
    _fetchUserData();
    _countUserList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
    backgroundColor: Constant.kPrimaryColor.withOpacity(0.8),
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
      "Manage Cars",
      style: TextStyle(
        fontFamily: "Raleway",
        color: Colors.white,
        fontSize: 18.0
      ),
      ),
      actions: [
         Padding(
           padding: const EdgeInsets.only(right:5.0),
           child: CircleAvatar(
                    radius: 20,
                   child: Text( carCount.isNotEmpty 
                  ? "${carCount[0]['count(*)'].toString()}"
                  : "0",), 
                  ),
         )
      ],
  ),
      body: Container(
        color: Constant.kPrimaryColor.withOpacity(0.03),
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           
            SizedBox(height: 10.0,),
          Expanded(flex: 10,
          child:
           Container(
             height: MediaQuery.of(context).size.height*0.73,
             child: carList.isNotEmpty ? ListView.builder(
                shrinkWrap: true,
                 itemCount: carList == null ? 0 : carList.length,
                itemBuilder: (BuildContext context, int index) {
                      return userTile(
                    context,
                    carList[index]['name'] +' '+ carList[index]['brand'] + ' '+ carList[index]['model'],
                    carList[index]['price'],
                    carList[index]['color'],
                    (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminCarDetails(data: carList.where((element) => element['car_id'] == carList[index]['car_id']).toList(),),));
                    }, 
                      () async{

                             showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("Confirm"),
                    content:
                        new Text("Are you sure you want to delete this car?"),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new RaisedButton(
                                color: Colors.red,
                                child: Row(
                                  children: <Widget>[
                                    new Text("YES", style: TextStyle(color: Colors.white),),
                                    SizedBox(width: 5.0),
                                    Icon(Icons.check_circle, color: Colors.white,),
                                  ],
                                ),
                                onPressed: () async{
                                var id = carList[index]['car_id'];
                                  await http.post(Uri.parse("https://saniabdullahi.com.ng/result.php"), body: {
                                      "request": "DELETE CAR",
                                      "id": id,
                                      });
                               _fetchUserData();
                               _countUserList();
                                  Navigator.of(context, rootNavigator: true).pop('dialog');
                                },
                              ),
                              new RaisedButton(
                                color: Colors.blueAccent,
                                child: Row(
                                  children: <Widget>[
                                    new Text("NO", style: TextStyle(color: Colors.white),),
                                    SizedBox(width: 5.0),
                                    Icon(Icons.cancel, color: Colors.white,)
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).pop('dialog');
                                },
                              ),
                            ]),
                      )
                    ],
                  );
                },
              );
                            
                          },
                    
                    _fetchUserData(),
                    carList[index]['picture']
                  );
                 
                }
              
              ) :   Center(child: CircularProgressIndicator(strokeWidth: 2,),),
           ),
          ),
   
         ], 
        ),
      ),
      //   floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //       // Navigator.push(
      //       //             context,
      //       //             MaterialPageRoute(
      //       //                 builder: (context) => AddAgent()));
      //   },
      //   child: Icon(Icons.add),
      //   elevation: 4,
      // ),
    );
  }
}

Widget userTile(context, String? name, String? regno, String? level, Function() route, Function() route2, fetchStudentData, String? img){
  return Column(
    children: [
      GestureDetector(
                      onTap: route,
                      child: Material(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.only(topLeft: Radius.circular(12)),
                           border: Border(left: BorderSide(width: 5.0, color: Constant.kPrimaryColor.withOpacity(0.6))),
                         
                          ),
                        width: MediaQuery.of(context).size.width,
                        child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network('https://saniabdullahi.com.ng/user_uploads/${img.toString()}',height: 70, width: 70,),
                                      SizedBox(
                                    width: 10.0,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                              name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Quando',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600
                                              ),
                                              
                                            ),
                                            
                                            SizedBox( height: 5.0,),
                                            Text(
                                              "Price: $regno",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox( height: 5.0,),
                                            Text(
                                              "Color: $level",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            
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
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete,size: 20, color: Colors.black54,),
                              onPressed: route2
                            ),
                                                      ],
                        )
                              ],
                            ),
                      ),
                      ),
                    ),
                    SizedBox(height: 15,),
    ],
  );
}