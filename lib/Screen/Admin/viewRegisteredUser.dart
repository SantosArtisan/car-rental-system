import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewRegisteredUser extends StatefulWidget {
  const ViewRegisteredUser({Key? key}) : super(key: key);

  @override
  _ViewRegisteredUserState createState() => _ViewRegisteredUserState();
}

class _ViewRegisteredUserState extends State<ViewRegisteredUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Constant.kPrimaryColor.withOpacity(0.8),
                    Constant.kPrimaryColor.withOpacity(0.3),
                  ],
                  begin: Alignment.centerLeft,
                  end: new Alignment(1.0, 1.0),
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: 130,
          left: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('img/user-icon.jpg'),
                radius: 70,
              )
            ],
          ),
        ),
        Positioned(
            top: 290,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(FontAwesomeIcons.userAlt),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Sani Abdullahi",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(FontAwesomeIcons.mailBulk),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'saniabdullahi442@gmail.com',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(FontAwesomeIcons.mobile),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '08165426897',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          FontAwesomeIcons.addressBook,
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Kuchigoro Jabi Abuja',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))
      ],
    ));
  }
}
