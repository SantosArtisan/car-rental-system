import 'package:car_rental/Screen/Admin/viewRegisteredUser.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:car_rental/Widget/user_widget.dart';

class RegisteredUser extends StatefulWidget {
  const RegisteredUser({Key? key}) : super(key: key);

  @override
  _RegisteredUserState createState() => _RegisteredUserState();
}

class _RegisteredUserState extends State<RegisteredUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: registeredUserAppBar(title: '', context: context),
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
                          backgroundImage: AssetImage('img/user-icon.jpg'),
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
                            'Sani Hassan Abdullahi',
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
                          backgroundImage: AssetImage('img/user-icon.jpg'),
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
                            'Adam Musa Yau Shinkafi',
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
