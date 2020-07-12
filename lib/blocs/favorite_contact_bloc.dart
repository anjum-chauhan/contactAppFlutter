import 'package:contactapp/database/contact_database.dart';
import 'package:contactapp/models/contact.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteContactsBloc {
  final _favContacts = BehaviorSubject<List<Contact>>();
  // reference to our single class that manages the database
  final _dbHelper = ContactDatabase.instance;

  FavoriteContactsBloc (){
    _fetchFavContacts();
  }

  void dispose() {
    _favContacts.close();
  }

  _fetchFavContacts() =>
      _dbHelper.getFavoriteContacts().then((contacts) => changeContacts(contacts));

  //Set Data
  Function(List<Contact>) get changeContacts => _favContacts.sink.add;

  Stream<List<Contact>> get contacts => _favContacts.stream;


}
