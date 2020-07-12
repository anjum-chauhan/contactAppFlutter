import 'package:contactapp/blocs/contact_provider.dart';
import 'package:contactapp/models/contact.dart';
import 'package:flutter/material.dart';

import 'contact_details_page.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ContactsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Contact List'),
      ),
      body: StreamBuilder<List<Contact>>(
        stream: bloc.favContact,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text('No Favorite Contacts'),
            );
          else
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
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
        },
      ),
    );
  }
}
