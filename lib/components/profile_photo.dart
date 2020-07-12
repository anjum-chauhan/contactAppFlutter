import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final profileURl;

  ProfilePhoto({this.profileURl});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          maxRadius: 80,
          backgroundImage: NetworkImage(profileURl),
//                    child: Icon(
//                      Icons.person,
//                      size: 60,
//                    ),
        ),
      ],
    );
  }
}
