import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:car_rental/Screen/Customer/customerLogin.dart';
import 'package:car_rental/Widget/user_widget.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
    onVisible: () {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CustomerLogin()));
      });
    },
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

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController fullnameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController ninController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String? fullname;
  String? address;
  String? email;
  String? phone;
  String? nin;
  String? password;
  // File? imageFile;

  void _signUp() async {
    final uri = Uri.parse('https://saniabdullahi.com.ng/result.php');
    var request = http.MultipartRequest('Post', uri);
    request.fields['request'] = "ADD USER";
    request.fields['userFullname'] = fullname!;
    request.fields['userAddress'] = address!;
    request.fields['userEmail'] = email!;
    request.fields['userNin'] = nin!;
    request.fields['userPhone'] = phone!;
    request.fields['userPassword'] = password!;

    // var pick = await http.MultipartFile.fromPath('image', imageFile!.path);
    // request.files.add(pick);
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
      _signUp();
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
      appBar: signUpAppBar(title: '', context: context),
      body: SingleChildScrollView(
        child: Container(
          color: Constant.kPrimaryColor.withOpacity(0.01),
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Sign Up Here',
                    style: TextStyle(
                        color: Constant.kPrimaryColor.withOpacity(0.8),
                        fontFamily: 'Quando',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Center(child: showImage()),
                  // IconButton(
                  //     icon: Icon(
                  //       Icons.camera_alt,
                  //     ),
                  //     onPressed: () {
                  //       selectImage();
                  //     }),
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
                    controller: fullnameController,
                    onSaved: (val) => fullname = val,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'Contact Address'),
                    validator: (value) => value?.length == 0
                        ? 'Please enter contact Address'
                        : null,
                    controller: addressController,
                    onSaved: (val) => address = val,
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
                    onSaved: (val) => email = val,
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
                    onSaved: (val) => phone = val,
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
                    obscureText: true,
                    controller: passwordController,
                    onSaved: (val) => password = val,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'NIN Number'),
                    validator: (value) =>
                        value?.length == 0 ? 'Please enter NIN Number' : null,
                    controller: ninController,
                    onSaved: (val) => nin = val,
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

  // showImage() {
  //   if (imageFile != null) {
  //     return CircleAvatar(
  //       backgroundImage: FileImage(imageFile!),
  //       radius: 70,
  //     );
  //   } else {
  //     return CircleAvatar(
  //       backgroundColor: Colors.blueGrey,
  //       child: Icon(
  //         Icons.person,
  //         size: 90,
  //       ),
  //       radius: 70,
  //     );
  //   }
  // }

  // void selectImage() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //           content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           InkWell(
  //             onTap: () {
  //               Navigator.of(context, rootNavigator: true).pop('dialog');

  //               chooseImage(ImageSource.camera);
  //             },
  //             child: Row(
  //               children: [
  //                 Icon(Icons.camera_alt),
  //                 SizedBox(width: 20),
  //                 Text('Take Photo'),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 29),
  //           InkWell(
  //             onTap: () {
  //               chooseImage(ImageSource.gallery);
  //               Navigator.of(context, rootNavigator: true).pop('dialog');
  //             },
  //             child: Row(
  //               children: [
  //                 Icon(Icons.photo_library),
  //                 SizedBox(width: 20),
  //                 Text('Choose Photo'),
  //               ],
  //             ),
  //           )
  //         ],
  //       ));
  //     },
  //   );
  // }

  // chooseImage(ImageSource source) async {
  //   PickedFile? pickedImage = await ImagePicker().getImage(source: source);
  //   setState(() {
  //     imageFile = File(pickedImage!.path);
  //   });
  // }
}
