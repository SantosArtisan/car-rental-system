import 'dart:convert';

import 'package:car_rental/Screen/Customer/car_details.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:carousel_pro/carousel_pro.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}


class _CustomerDashboardState extends State<CustomerDashboard> {
  String? userfullname;
String? useremail;
String? userpassword;
String? userid;
List carsData = [];

  getData() async{
    Constant.sharedPref = await SharedPreferences.getInstance();
    setState(() {
      userid = Constant.sharedPref?.getString('user');
    userfullname = Constant.sharedPref?.getString('fullname');
    useremail = Constant.sharedPref?.getString('email');
    userpassword = Constant.sharedPref?.getString('password');
    });
  }

  Future<List> _fetchCarData() async {
        final response =
        await http.post(Uri.parse("https://saniabdullahi.com.ng/result.php"), body: {
        "request": "FETCH ALL CARS",
          });
          var convertDateToJson = jsonDecode(response.body);
        setState(() {
        carsData = convertDateToJson;
      });
      return carsData;
      }
 

      
@override
  void initState() {
    getData();
    _fetchCarData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(children: [
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi ${userfullname},',
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
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('img/user-icon.jpg'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
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
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GCRS',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quando',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'The best car rental service',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Raleway',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        child: Text(
                          'View More',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Raleway',
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Card(
                    color: Constant.kPrimaryColor.withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Available Cars',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Click the icon to see more',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {}),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Search',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontSize: 16.0,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          'View More',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Raleway',
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: carsData.isNotEmpty ? carsData.length : 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    //  Map recipe = recipes[index];
                    return _carsCard(
                      context: context, 
                      name: carsData[index]["name"], 
                      img: carsData[index]["picture"],
                      route: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> CarDetails(data: carsData.where((element) => element['car_id'] == carsData[index]['car_id']).toList(),),));
                      }
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Sani Abdullahi'),
              accountEmail: Text('saniabdullahi442@gmail.com'),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.car_rental,
                  size: 50,
                ),
                backgroundColor: Constant.kPrimaryColor.withOpacity(0.4),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.home),
              title: Text('Home'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/addCar');
              },
              leading: Icon(Icons.car_rental),
              title: Text('Add Car'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/manageCar');
              },
              leading: Icon(Icons.car_rental),
              title: Text('Manage Car'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/adminProfile');
              },
              leading: Icon(Icons.person),
              title: Text('Profile'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/about');
              },
              leading: Icon(Icons.info),
              title: Text('About'),
              trailing: Icon(Icons.arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _carsCard({context, String? name, String? img, Function()? route }) {
  return InkWell(
    onTap: route,
                        splashColor: Colors.grey[200],
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Card(
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Constant.kPrimaryColor
                                              .withOpacity(0.9),
                                        ),
                                        child: Icon(
                                          Icons.car_rental,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 3,),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start, 
                                        children: [
                                          Image.network(
                                            'https://saniabdullahi.com.ng/user_uploads/${img!}',
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              name!,
                                              style: TextStyle(
                                                fontFamily: 'Quando',
                                                fontSize: 14,
                                                color: Constant.kPrimaryColor
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))));
}
