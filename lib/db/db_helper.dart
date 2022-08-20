import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/contact_model.dart';

final List<ContactModel> contactList = [
  ContactModel(name: 'A', mobile: '01700000000', email: 'a@gmail.com', streetAddress: 'finlay square, Chittagong'),
  ContactModel(name: 'B', mobile: '01700000001', email: 'a@gmail.com', streetAddress: 'Mirpur 1, Dhaka'),
  ContactModel(name: 'C', mobile: '01700000002', email: 'a@gmail.com'),
  ContactModel(name: 'D', mobile: '01700000003', email: 'a@gmail.com'),
  ContactModel(name: 'E', mobile: '01700000004', email: 'a@gmail.com'),
  ContactModel(name: 'A1', mobile: '01700000000', email: 'a@gmail.com'),
  ContactModel(name: 'B1', mobile: '01700000001', email: 'a@gmail.com'),
  ContactModel(name: 'C1', mobile: '01700000002', email: 'a@gmail.com'),
  ContactModel(name: 'D1', mobile: '01700000003', email: 'a@gmail.com'),
  ContactModel(name: 'E1', mobile: '01700000004', email: 'a@gmail.com'),
  ContactModel(name: 'A2', mobile: '01700000000'),
  ContactModel(name: 'B2', mobile: '01700000001'),
  ContactModel(name: 'C2', mobile: '01700000002'),
  ContactModel(name: 'D2', mobile: '01700000003'),
  ContactModel(name: 'E2', mobile: '01700000004'),
];

class DBHelper {
  static const String createTableContact = '''create table $tableContact(
  $tblContactColId integer primary key autoincrement,
  $tblContactColName text,
  $tblContactColMobile text,
  $tblContactColEmail text,
  $tblContactColAddress text,
  $tblContactColDob text,
  $tblContactColGender text,
  $tblContactColFavorite integer,
  $tblContactColName image)''';

  static Future<Database> open() async{
  final rootPath = await getDatabasesPath();
  final dbPath = join(rootPath, 'contact.db');
  return openDatabase(dbPath, version: 1, onCreate: (db, version) {
    db.execute(createTableContact);
  });
  }

  static Future<int> insertContact(ContactModel contactModel) async{
    final db = await open();
    return db.insert(tableContact, contactModel.toMap());
  }
}