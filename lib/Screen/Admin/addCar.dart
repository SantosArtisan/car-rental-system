import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:car_rental/Widget/user_widget.dart';
import 'package:car_rental/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  _AddCarState createState() => _AddCarState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

_showSnackBar(context) {
  final snackbar = new SnackBar(
    content: Text('Car added successfully',
        style: TextStyle(
          fontSize: 14.0,
          backgroundColor: Colors.black54,
          color: Colors.white,
        )),
  );
  _scaffoldKey.currentState?.showSnackBar(snackbar);
}

_showErrorSnackBar(context) {
  final snackbar = new SnackBar(
      content: Text(
    'Error adding car',
    style: TextStyle(
      fontSize: 14.0,
      backgroundColor: Colors.black54,
      color: Colors.white,
    ),
  ));
  _scaffoldKey.currentState?.showSnackBar(snackbar);
}

class _AddCarState extends State<AddCar> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController brandController = new TextEditingController();
  TextEditingController modelController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController colorController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();

  String? name;
  String? brand;
  String? model;
  String? price;
  String? color;
  File? imageFile;

  void _addCar() async {
    final uri = Uri.parse('https://saniabdullahi.com.ng/result.php');
    var request = http.MultipartRequest('Post', uri);
    request.fields['request'] = "ADD CAR";
    request.fields['name'] = name!;
    request.fields['brand'] = brand!;
    request.fields['model'] = model!;
    request.fields['price'] = price!;
    request.fields['color'] = color!;

    var pick = await http.MultipartFile.fromPath('image', imageFile!.path);
    request.files.add(pick);
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

  _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      setState(() {
        isLoading = true;
      });
      isLoading
          ? _showDialog()
          : Navigator.of(context, rootNavigator: true).pop('dialog');
      Timer(Duration(seconds: 3), () {});
      _addCar();
    } else {
      _showErrorSnackBar(context);
    }
  }

  // Future getFiles() async {
  //   File file = await FilePicker.getFile(type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);

  //      setState(() {
  //       _file = file;
  //       });

  // }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 25.0,
              ),
              Text('Please Wait......')
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addCarAppBar(title: '', context: context),
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
                    height: 20.0,
                  ),
                  Text(
                    'Admin panel to add a new car',
                    style: TextStyle(
                      color: Constant.kPrimaryColor.withOpacity(0.8),
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(child: showImage()),
                  IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                      ),
                      onPressed: () {
                        selectImage();
                      }),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) => value?.length == 0
                        ? 'Please enter the model year'
                        : null,
                         controller: nameController,
                        onSaved: (val) => name = val,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'Brand'),
                    validator: (value) => value?.length == 0
                        ? 'Please enter the model year'
                        : null,
                    controller: brandController,
                    onSaved: (val) => brand = val,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'Model Year'),
                    validator: (value) => value?.length == 0
                        ? 'Please enter the model year'
                        : null,
                    controller: modelController,
                    onSaved: (val) => model = val,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                      decoration: InputDecoration(labelText: 'Price Per Hour'),
                      validator: (value) => value?.length == 0
                          ? 'Please enter price per hour'
                          : null,
                      controller: priceController,
                      onSaved: (val) => price = val,
                          ),

                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(labelText: 'Color'),
                    validator: (val) =>
                        val?.length == 0 ? 'Please Enter Color' : null,
                    controller: colorController,
                    onSaved: (val) => color = val,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  //   child: FlatButton(
                  //     highlightColor: Constant.kPrimaryColor.withOpacity(0.2),
                  //     splashColor: Constant.kPrimaryColor.withOpacity(0.1),
                  //     color: Colors.white,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Icon(FontAwesomeIcons.image, color: Colors.black54),
                  //         Text(
                  //           'Click here to choose a Image',
                  //           style: TextStyle(fontSize: 14, color: Colors.black),
                  //         ),
                  //         Icon(Icons.cloud_upload, color: Colors.black54),
                  //       ],
                  //     ),
                  //     shape: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           color: Constant.kPrimaryColor.withOpacity(0.3),
                  //           width: 2),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     padding: EdgeInsets.all(18),
                  //     textColor: Colors.white,
                  //     onPressed: () {
                  //       getFiles();
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Constant.kPrimaryColor.withOpacity(0.8),
                    ),
                    onPressed: () {
                      _login();
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

  showImage() {
    if (imageFile != null) {
      return CircleAvatar(
        backgroundImage: FileImage(imageFile!),
        radius: 70,
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.person,
          size: 90,
        ),
        radius: 70,
      );
    }
  }

  void selectImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');

                chooseImage(ImageSource.camera);
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 20),
                  Text('Take Photo'),
                ],
              ),
            ),
            SizedBox(height: 29),
            InkWell(
              onTap: () {
                chooseImage(ImageSource.gallery);
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 20),
                  Text('Choose Photo'),
                ],
              ),
            )
          ],
        ));
      },
    );
  }

  chooseImage(ImageSource source) async {
    var pickedImage = await ImagePicker().getImage(source: source);
    // setState(() {
    //   imageFile = pickedImage;
    // });
    setState(() {
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
      }
    });
  }
}
