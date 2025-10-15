part of 'login_cubit.dart';

class LoginSuccessState extends SuccessState<UserEntity> {
  const LoginSuccessState(super.data);
}

class ValidationState extends BaseState {
  const ValidationState();
}

class PasswordVisibilityChangedState extends BaseState {
  final bool isObscure;
  const PasswordVisibilityChangedState(this.isObscure);
}
