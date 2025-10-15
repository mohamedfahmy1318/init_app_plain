import 'package:equatable/equatable.dart';
import '../../../../core/base/base_entity.dart';

class UserEntity extends BaseEntity with EquatableMixin {
  final String name;
  final String email;
  final String role;
  final String token;

  const UserEntity({
    required this.name,
    required this.email,
    required this.role,
    required this.token,
  });

  @override
  List<Object?> get props => [name, email, role, token];
}
