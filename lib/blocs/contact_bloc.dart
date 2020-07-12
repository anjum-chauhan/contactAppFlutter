import 'package:contactapp/database/contact_database.dart';
import 'package:contactapp/models/contact.dart';
import 'package:rxdart/rxdart.dart';

class ContactsBloc {
  final _contacts = BehaviorSubject<List<Contact>>();
  final _favContact = BehaviorSubject<List<Contact>>();

  // reference to our single class that manages the database
  final _dbHelper = ContactDatabase.instance;
  ContactsBloc() {
    _fetchContacts();
    _fetchFavContacts();
  }
  //Get Data
  Stream<List<Contact>> get contacts => _contacts.stream;
  Stream<List<Contact>> get favContact => _favContact.stream;

  //Set Data
  Function(List<Contact>) get changeContacts => _contacts.sink.add;
  Function(List<Contact>) get changeFavContacts => _favContact.sink.add;

  _fetchContacts() => _dbHelper.getAllContacts().then((contacts) {
        contacts.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        return changeContacts(contacts);
      });

  _fetchFavContacts() => _dbHelper.getFavoriteContacts().then((contacts) {
        contacts.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        return changeFavContacts(contacts);
      });
  void dispose() {
    _contacts.close();
    _favContact.close();
  }
}
