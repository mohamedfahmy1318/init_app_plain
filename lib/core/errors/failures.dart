/// ========================================================
/// Failure - نموذج الأخطاء
/// ========================================================
/// يستخدم مع Either من dartz للتعامل مع الأخطاء بشكل وظيفي
/// ========================================================
library;

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// ==================== Server Failure ====================
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// ==================== Cache Failure ====================
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// ==================== Network Failure ====================
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// ==================== Validation Failure ====================
class ValidationFailure extends Failure {
  final Map<String, dynamic>? errors;

  const ValidationFailure(super.message, {this.errors});

  @override
  List<Object?> get props => [message, errors];
}

// ==================== Unauthorized Failure ====================
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

// ==================== Auth Failure ====================
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

// ==================== Not Found Failure ====================
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

// ==================== Conflict Failure ====================
class ConflictFailure extends Failure {
  const ConflictFailure(super.message);
}

// ==================== Unknown Failure ====================
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
