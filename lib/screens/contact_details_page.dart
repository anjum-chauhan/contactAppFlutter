import 'package:contactapp/components/custom_inputfield.dart';
import 'package:contactapp/components/profile_photo.dart';
import 'package:contactapp/components/utility.dart';
import 'package:contactapp/database/contact_database.dart';
import 'package:contactapp/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_new_contact_page.dart';

class ContactDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactDetailsPage();
  ContactDetailsPage({@required this.contact});
  final Contact contact;
}

class _ContactDetailsPage extends State<ContactDetailsPage> {
  final _dbHelper = ContactDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Contact'),
          actions: <Widget>[
            GestureDetector(
              child: Center(
                child: Text(
                  'update'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () async {
                if (widget.contact.email.isNotEmpty ||
                    widget.contact.name.isNotEmpty ||
                    widget.contact.phoneNumber != null) {
                  await _dbHelper.updateContact(widget.contact);
                  Navigator.pop(context);
                } else
                  print('please fill out details');
              },
            ),
            SizedBox(
              width: 15,
            ),
            //update button
            GestureDetector(
              child: Icon(widget.contact.favorite == 0
                  ? kFavBorderUnfilled
                  : kFavBorderFilled),
              onTap: () {
                setState(() {
                  widget.contact.favorite =
                      widget.contact.favorite == 0 ? 1 : 0;
                });
                print(widget.contact.favorite);
              },
            ),
            SizedBox(
              width: 15,
            ),
            //delete Button
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                bool isConfirmed = false;
                await showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('AlertDialog Title'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('This is a demo alert dialog.'),
                            Text('Would you like to approve of this message?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            isConfirmed = false;
                          },
                        ),
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            isConfirmed = true;
                          },
                        ),
                      ],
                    );
                  },
                );
                if (isConfirmed) {
                  await _dbHelper.deleteContact(widget.contact.id);
                  Navigator.pop(context);
                }
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
                      child: (widget.contact.profilepic == null ||
                              widget.contact.profilepic.trim() == '')
                          ? CircleAvatar(child: Icon(Icons.person))
                          : Container(
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(60.0),
                                child: Utility.imageFromBase64String(
                                    widget.contact.profilepic),
                              ),
                            ),
                    ),
                    FlatButton(
                      child: Text(
                        'Change Photo',
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                      onPressed: () => {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //name
                CustomInputField(
                  initialValue: widget.contact.name,
                  onChanged: (value) {
                    widget.contact.name = value;
                  },
                  hintText: 'Name',
                  txtInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                //email
                CustomInputField(
                  initialValue: widget.contact.email,
                  onChanged: (value) {
                    widget.contact.email = value;
                  },
                  hintText: 'email',
                  txtInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                //phone number
                CustomInputField(
                  initialValue: widget.contact.phoneNumber,
                  onChanged: (value) {
                    widget.contact.phoneNumber = value;
                  },
                  hintText: 'phone',
                  txtInputType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ));
  }
}
