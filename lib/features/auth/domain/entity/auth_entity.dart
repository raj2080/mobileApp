import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role="user";
  final String password;


  
  const AuthEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
   
    required this.password, 
  });

  @override
  List<Object?> get props =>
      [id, firstName, lastName, email, phone, password];
}
