import '../../../../core/network/dio_client.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await client.post('/auth/signin', data: request.toJson());
    return LoginResponseModel.fromJson(response.data);
  }
}
