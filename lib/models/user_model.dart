class UserModel {
  final String email;
  final dynamic userName;
  final dynamic uid;
  final dynamic photoURl;
  final dynamic password;
  final String bio;

  UserModel({
    required this.uid,
    required this.photoURl,
    required this.email,
    required this.userName,
    required this.password,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username": userName,
        "password": password,
        "bio": bio,
        "profilePic": photoURl
      };
}
