import 'dart:async';
import 'dart:io';

import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:car_rental/Widget/user_widget.dart';
import 'package:http/http.dart' as http;

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
_showSnackBar(context) {
  final snackbar = new SnackBar(
    content: Text(
      'Successfully',
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
        backgroundColor: Colors.black54,
      ),
    ),
  );
  _scaffoldKey.currentState?.showSnackBar(snackbar);
}

_showErrorSnackBar(context) {
  final snackbar = new SnackBar(
    content: Text(
      'Login Fail',
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
        backgroundColor: Colors.black54,
      ),
    ),
  );
  _scaffoldKey.currentState?.showSnackBar(snackbar);
}

class _AddAdminState extends State<AddAdmin> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController fullnameController = new TextEditingController();
  TextEditingController designationController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String? fullname;
  String? designation;
  String? email;
  String? phone;
  String? password;

  void _addAdmin() async {
    final uri = Uri.parse('');
    var request = http.MultipartRequest('Post', uri);
    request.fields['request'] = "ADD ADMIN";
    request.fields['userFullname'] = fullname!;
    request.fields['userDesignation'] = designation!;
    request.fields['userPhone'] = phone!;
    request.fields['userEmail'] = email!;
    request.fields['userPassword'] = password!;

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      isLoading
          ? _showDialog()
          : Navigator.of(context, rootNavigator: true).pop('dialog');
      _showSnackBar(context);
    }
    setState(() {
      isLoading = false;
    });
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      setState(() {
        isLoading = true;
      });
      isLoading
          ? _showDialog()
          : Navigator.of(context, rootNavigator: true).pop('dialog');
      Timer(Duration(seconds: 3), () {});
      _addAdmin();
    } else {
      _showErrorSnackBar(context);
    }
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 25.0),
            Text('Please wait...'),
          ],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: addAdminAppBar(title: '', context: context),
      body: SingleChildScrollView(
        child: Container(
          color: Constant.kPrimaryColor.withOpacity(0.01),
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      labelText: 'FullName',
                    ),
                    validator: (value) =>
                        value?.length == 0 ? 'Please enter Fullname' : null,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'Designation'),
                    validator: (value) => value?.length == 0
                        ? 'Please enter the designation'
                        : null,
                    controller: designationController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'Email Address'),
                    validator: (value) => value?.length == 0
                        ? 'Please enter email address'
                        : null,
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'Mobile Number'),
                    validator: (value) => value?.length == 0
                        ? 'Please enter Mobile Number'
                        : null,
                    controller: phoneController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) =>
                        value?.length == 0 ? 'Please enter Password' : null,
                    controller: passwordController,
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
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
