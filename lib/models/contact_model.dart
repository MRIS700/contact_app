const String tableContact = 'table_contact';
const String tblContactColId = 'id';
const String tblContactColName = 'name';
const String tblContactColMobile = 'mobile';
const String tblContactColEmail = 'email';
const String tblContactColDob = 'dob';
const String tblContactColAddress = 'address';
const String tblContactColGender = 'gender';
const String tblContactColFavorite = 'favorite';
const String tblContactColImage = 'image';

class ContactModel {
  int? id;
  String name;
  String mobile;
  String? email;
  String? dob;
  String? streetAddress;
  String? gender;
  bool favorite;
  String? image;

  ContactModel(
      {this.id,
      required this.name,
      required this.mobile,
      this.email,
      this.dob,
      this.streetAddress,
      this.gender,
      this.favorite = false,
      this.image});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tblContactColName : name,
      tblContactColMobile : mobile,
      tblContactColEmail : email,
      tblContactColAddress : streetAddress,
      tblContactColDob : dob,
      tblContactColGender : gender,
      tblContactColFavorite : favorite ? 1 : 0,
      tblContactColImage : image
    };
    if(id != null){
      map[tblContactColId] = id;
    }
    return map;
  }
}
