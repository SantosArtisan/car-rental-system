import 'dart:async';
import 'package:car_rental/Home/signUp.dart';
import 'package:car_rental/Screen/Customer/customerDashboard.dart';
import 'package:car_rental/Widget/user_widget.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _enterPassword = true;
bool isLoading = false;
bool? isLoggedIn = false;

class CustomerLogin extends StatefulWidget {
  @override
  _CustomerLoginState createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String? mail;
  String? password;

  _showSuccessSnackBar(context) {
    final snackbar = new SnackBar(
      content: new Text(
        'Login Successfully',
        style: TextStyle(color: Colors.greenAccent, fontSize: 16.0),
      ),
      onVisible: () {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => CustomerDashboard()));
        });
      },
      backgroundColor: Colors.black54,
    );
    _scaffoldKey.currentState?.showSnackBar(snackbar);
  }

  _showIncorrectSnackBar(context) {
    final snackbar = new SnackBar(
      content: new Text(
        'Login Fail',
        style: TextStyle(color: Colors.red, fontSize: 16.0),
      ),
      backgroundColor: Colors.black54,
    );
    _scaffoldKey.currentState?.showSnackBar(snackbar);
  }

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

  _login() async {
    final response = await http
        .post(Uri.parse("https://saniabdullahi.com.ng/result.php"), body: {
      "request": "CUSTOMER LOGIN",
      "email": mail,
      "password": password,
    });

    List datauser = json.decode(response.body);
    print(datauser);

    if (datauser.length == 0) {
      setState(() {
        isLoading = false;
      });
      isLoading
          ? Navigator.of(context, rootNavigator: true).pop('dialog')
          : _showDialog();
      _showIncorrectSnackBar(context);
    } else {
      if (response.statusCode == 200) {
        Constant.sharedPref = await SharedPreferences.getInstance();
         setState(() {
          Constant.sharedPref?.setString("user", datauser[0]['customer_id']);
          Constant.sharedPref?.setString("fullname", datauser[0]['fullname']);
          Constant.sharedPref?.setString("email", datauser[0]['email']);
          Constant.sharedPref?.setString("password", datauser[0]['password']);
          Constant.sharedPref?.setBool("isLoggedIn", true);
          isLoading = false;
        });
        isLoading
            ? Navigator.of(context, rootNavigator: true).pop('dialog')
            : _showDialog();
        _showSuccessSnackBar(context);
      }
    }

    return datauser;
  }

  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _formKey.currentState?.save();
        setState(() {
          isLoading = true;
        });
        isLoading
            ? _showDialog()
            : Navigator.of(context, rootNavigator: true).pop('dialog');
        Timer(Duration(seconds: 3), () {});
        _login();
      } else {
        _showerr();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    checkLoginState();
  }

  getData() async {
    setState(() {
      isLoggedIn = Constant.sharedPref?.getBool("isLoggedIn");
    });
  }

  checkLoginState() {
    if (isLoggedIn == true) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
      Future.delayed(Duration.zero, () async {
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CustomerDashboard()),
            (Route<dynamic> route) => false);
        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminBottomNav()));
      });
    } else {}
  }

  void _showerr() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Row(
            children: <Widget>[
              new Icon(Icons.cancel, size: 30.0, color: Colors.deepOrange[200]),
              SizedBox(
                width: 20.0,
              ),
              new Text("No internet connection!"),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: loginAppBar(title: " ", context: context),
      body: Container(
        color: Constant.kPrimaryColor.withOpacity(0.01),
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Constant.kPrimaryColor.withOpacity(0.8),
                        fontFamily: 'Quando',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Email ",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: email,
                    onSaved: (val) => mail = val,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          size: 20.0,
                          color: Colors.black54,
                        ),
                        hintText: 'saniabdullahi442@gmail.com',
                        fillColor: Colors.grey,
                        filled: true,
                        contentPadding: EdgeInsets.all(10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Password ",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: pass,
                    onSaved: (val) => password = val,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.0,
                    ),
                    obscureText: _enterPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 20.0,
                        color: Colors.black54,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 20.0,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          if (_enterPassword) {
                            setState(() {
                              _enterPassword = true;
                            });
                          } else {
                            setState(() {
                              _enterPassword = false;
                            });
                          }
                        },
                      ),
                      hintText: '********',
                      contentPadding: EdgeInsets.all(15.0),
                      filled: true,
                      fillColor: Colors.grey,
                      focusColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Constant.kPrimaryColor.withOpacity(0.8),
                    ),
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Text(
                            'Forgotten Password?',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16.0,
                              color: Constant.kPrimaryColor.withOpacity(0.8),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Text(
                                'If you have not register with us',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16.0,
                                  color:
                                      Constant.kPrimaryColor.withOpacity(0.8),
                                ),
                              ),
                            ),
                            InkWell(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16.0,
                                  color:
                                      Constant.kPrimaryColor.withOpacity(0.8),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
