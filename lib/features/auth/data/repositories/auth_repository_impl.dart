import 'package:dartz/dartz.dart';
import '../../../../core/base/base_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/storage/secure_storage_service.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_model.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorageService secureStorage;

  AuthRepositoryImpl(this.remoteDataSource, this.secureStorage);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    return execute(
      apiCall: () async {
        final request = LoginRequestModel(email: email, password: password);
        final response = await remoteDataSource.login(request);
        final user = response.toEntity();
        // Save token
        await secureStorage.write('auth_token', user.token);
        await secureStorage.write('user_name', user.name);
        await secureStorage.write('user_email', user.email);
        await secureStorage.write('user_role', user.role);

        return user;
      },
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return executeLocal(
      operation: () async {
        await secureStorage.delete('auth_token');
        await secureStorage.delete('user_name');
        await secureStorage.delete('user_email');
        await secureStorage.delete('user_role');
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    return executeLocal(
      operation: () async {
        final token = await secureStorage.read('auth_token');
        if (token == null) {
          throw Exception('No user logged in');
        }

        final name = await secureStorage.read('user_name') ?? '';
        final email = await secureStorage.read('user_email') ?? '';
        final role = await secureStorage.read('user_role') ?? '';

        return UserEntity(name: name, email: email, role: role, token: token);
      },
    );
  }
}
