import 'package:contactapp/components/custom_inputfield.dart';
import 'package:contactapp/components/utility.dart';
import 'package:contactapp/database/contact_database.dart';
import 'package:contactapp/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

const kFavBorderFilled = Icons.favorite;
const kFavBorderUnfilled = Icons.favorite_border;

const kCircleAvatar = CircleAvatar(
  maxRadius: 80,
  child: Icon(
    Icons.person,
    size: 60,
  ),
);

class AddContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddContact();
}

class _AddContact extends State<AddContact> {
  final _dbHelper = ContactDatabase.instance;
  Contact contact = Contact();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    contact.profilepic = await Utility.convertImageToBaseString(pickedFile);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Contact'),
        actions: <Widget>[
          GestureDetector(
            child: Center(
              child: Text(
                'Save'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () async {
              if ((contact.name != null && contact.name.isNotEmpty)) {
                await _dbHelper.insertContact(contact);
                Navigator.pop(context);
              } else
                Fluttertoast.showToast(
                    msg: "Please enter contact name",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black38,
                    textColor: Colors.white,
                    fontSize: 16.0);
            },
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            child: Icon((contact.favorite == null || contact.favorite == 0)
                ? kFavBorderUnfilled
                : kFavBorderFilled),
            onTap: () {
              setState(() {
                contact.favorite = contact.favorite == 0 ? 1 : 0;
              });
            },
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //circular avatar and a add photo button
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: _image == null
                        ? kCircleAvatar
                        : CircleAvatar(
                            maxRadius: 80,
                            backgroundImage: FileImage(_image),
                          ),
                  ),
                  FlatButton(
                    child: Text(
                      'Add Photo',
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                    onPressed: () => {getImage()},
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //name
              CustomInputField(
                onChanged: (value) {
                  contact.name = value;
                },
                hintText: 'Name',
                txtInputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              //email
              CustomInputField(
                onChanged: (value) {
                  contact.email = value;
                },
                hintText: 'email',
                txtInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              //phone number
              CustomInputField(
                onChanged: (value) {
                  contact.phoneNumber = value;
                },
                hintText: 'phone',
                txtInputType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
