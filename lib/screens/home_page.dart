import 'dart:io';

import 'package:contactapp/blocs/contact_provider.dart';
import 'package:contactapp/components/utility.dart';
import 'package:contactapp/models/contact.dart';
import 'package:contactapp/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'add_new_contact_page.dart';
import 'contact_details_page.dart';

class HomePage extends StatefulWidget {
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = ContactsProvider.of(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contact List Screen'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text('Favorite Contacts'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Favorites(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text('Add New Contact'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddContact(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Contact List'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Favorites'.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Favorites(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Contact>>(
          stream: bloc.contacts,
          builder: (context, snapshot) {
            if (snapshot.data == null || snapshot.data.length == 0) {
              return Center(
                child: Text('No contacts added.'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                String profPic = snapshot.data[index].profilepic;
                return ListTile(
                  leading: Container(
                    child: (profPic == null || profPic.trim() == '')
                        ? CircleAvatar(child: Icon(Icons.person))
                        : Container(
                            height: 40,
                            width: 40,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(20.0),
                              child: Utility.imageFromBase64String(profPic),
                            ),
                          ),
                  ),
                  title: Text(snapshot.data[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactDetailsPage(
                          contact: snapshot.data[index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContact(),
            ),
          )
        },
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
