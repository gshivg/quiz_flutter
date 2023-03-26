class UserModel {
  late String uid;
  late String name;
  late String email;
  late String age;
  late int? imgId;

  UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.age,
    this.imgId,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['fullName'];
    email = map['email'];
    age = map['age'];
    imgId = map['imgId'];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "age": age,
      "imgId": imgId,
    };
  }
}
