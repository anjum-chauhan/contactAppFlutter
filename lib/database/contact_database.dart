import 'package:contactapp/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabase {
  // make this a singleton class
  ContactDatabase._privateConstructor();
  static final ContactDatabase instance = ContactDatabase._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    String dbPath = join(await getDatabasesPath(), 'my_contacts_database.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreate);

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            email TEXT, 
            phone TEXT,
            favorite INTEGER,
            profilepic TEXT)
        ''');
    print("Database was created!");
  }

//  Future<void> dummyAddNewContactToDatabase() async {
//    Contact c = Contact(
//        id: null,
//        name: 'Tom',
//        phoneNumber: 7018335445,
//        email: 'tmmstnchauhan@gmail.com');
//    await insertContact(c);
//  }

  //get all elements from the database
  Future<List<Contact>> getAllContacts() async {
    var client = await db;
    final List<Map<String, dynamic>> maps = await client.query('contacts');

    if (maps.isNotEmpty) {
      // Convert the List<Map<String, dynamic> into a List<Contact>.
      return List.generate(maps.length, (i) {
        return Contact(
          id: maps[i]['id'],
          name: maps[i]['name'],
          email: maps[i]['email'],
          phoneNumber: maps[i]['phone'],
          favorite: maps[i]['favorite'],
          profilepic: maps[i]['profilepic'],
        );
      });
    } else
      return [];
  }

  //get favorite contacts
  Future<List<Contact>> getFavoriteContacts() async {
    var allContacts = await getAllContacts();
    if (allContacts.any((element) => element.favorite == 1)) {
      return allContacts.where((element) => element.favorite == 1).toList();
    } else
      return [];
  }

  // Define a function that inserts contacts into the database
  Future<void> insertContact(Contact contact) async {
    var client = await db;
    var output = await client.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(output);
  }

  Future<void> updateContact(Contact contact) async {
    var client = await db;
    await client.update(
      'contacts',
      contact.toMap(),
      where: "id = ?",
      // use whereArg to prevent SQL injection.
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int id) async {
    var client = await db;
    await client.delete(
      'contacts',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
