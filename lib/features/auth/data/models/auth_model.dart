import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_entity.dart';

class LoginResponseModel with EquatableMixin {
  final String message;
  final UserModel user;
  final String token;

  const LoginResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      name: user.name,
      email: user.email,
      role: user.role,
      token: token,
    );
  }

  @override
  List<Object?> get props => [message, user, token];
}

class UserModel with EquatableMixin {
  final String name;
  final String email;
  final String role;

  const UserModel({
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'role': role};
  }

  @override
  List<Object?> get props => [name, email, role];
}

class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
