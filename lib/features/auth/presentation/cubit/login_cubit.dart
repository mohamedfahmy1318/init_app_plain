import 'package:flutter/material.dart';
import '../../../../core/base/base_cubit.dart';
import '../../../../core/base/base_bloc.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/get_auths_usecase.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(const InitialState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(PasswordVisibilityChangedState(obscurePassword));
  }

  void validateEmail(String value) {
    emailError = Validators.email(value);
    emit(ValidationState());
  }

  void validatePassword(String value) {
    passwordError = Validators.password(value);
    emit(ValidationState());
  }

  bool get isValid => emailError == null && passwordError == null;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    validateEmail(email);
    validatePassword(password);

    if (!isValid) {
      emit(ValidationState());
      return;
    }

    emitLoading();

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) => emitError(failure.message),
      (user) => emit(LoginSuccessState(user)),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
