import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.name, required this.email, this.uid});

  final String name;
  final String email;
  final String? uid;

  @override
  List<Object?> get props => [name, email, uid];

  @override
  bool get stringify => true;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      uid: json['uid'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uid': uid,
    };
  }
}
