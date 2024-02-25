
class ProfileModel {

  String fname;
  String lname;
  String bio;
  String phone;
  String birthdate;
  String loginname;
  String img;
  int residence_region_id;
  int specialty_id;
  int gender_id;
  List<Map> residence_region;
  List<Map> specialties;

  ProfileModel({ required this.fname,required this.lname, required this.bio, required this.phone, required this.birthdate, required this.loginname, required this.img, required this.residence_region_id, required this.specialty_id, required this.gender_id, required this.residence_region, required this.specialties});

  factory ProfileModel.fromJson(Map json) {
  

    var listResidence_region = json['residence_region'] as List ?? [];
    List<Map> residence_regionList = listResidence_region.map((i) => i as Map).toList();

    var listSpecialties = json['specialties'] as List ?? [];
    List<Map> specialtiesList = listSpecialties.map((i) => i as Map).toList();

    return ProfileModel(
      fname: json['fname'],
      lname: json['lname'],
      bio: json['bio'],
      phone: json['phone'],
      birthdate: json['birthdate'],
      loginname: json['loginname'],
      img: json['img'],
      residence_region_id: json['residence_region_id'],
      specialty_id: json['specialty_id'],
      gender_id: json['gender_id'],
      residence_region: residence_regionList,
      specialties: specialtiesList,
    );
  }
  
  set set_gender_id(int? gender) {
    gender_id=gender!;
  }
  
  
}







