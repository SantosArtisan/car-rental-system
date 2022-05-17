import 'package:car_rental/Screen/Admin/viewRegisteredUser.dart';
import 'package:car_rental/Widget/user_widget.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';

class ManageCar extends StatefulWidget {
  const ManageCar({Key? key}) : super(key: key);

  @override
  _ManageCarState createState() => _ManageCarState();
}

class _ManageCarState extends State<ManageCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: manageCarAppBar(title: '', context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            children: [
              Card(
                child: InkWell(
                  highlightColor: Constant.kPrimaryColor.withOpacity(0.3),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewRegisteredUser()));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('img/car1.png'),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Camry 2021',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Satisfy',
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'saniabdullahi442@gmail.com',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Raleway',
                              // color: Colors.black54,
                            ),
                            // textAlign: TextAlign.center,
                            // overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Card(
                child: InkWell(
                  highlightColor: Constant.kPrimaryColor.withOpacity(0.3),
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('img/car2.png'),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Corola S',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Satisfy',
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'saniabdullahi442@gmail.com',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Raleway',
                            ),
                            // textAlign: TextAlign.center,
                            // overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
