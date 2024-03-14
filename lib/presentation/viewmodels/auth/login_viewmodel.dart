
import 'package:audaxious/domain/usecases/auth/login_usecase.dart';
import 'package:audaxious/presentation/screens/auth/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../widgets/custom_toast.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginUseCase loginUseCase;

  LoginViewModel({
    required this.loginUseCase,
  }) : super (LoginState.initial());

  static final notifier =
  StateNotifierProvider<LoginViewModel, LoginState>((ref) => LoginViewModel(
      loginUseCase: ref.read(loginUseCaseProvider),
  ));

Future<bool> loginUser(String email) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await loginUseCase.login(email);
      final success = response['success'];
      final data = response['data'];

      if (success != null && success == true) {
        if (data != null) {
          final user = User.fromJson(data);
          state = state.update(user: user);
        }

        state = state.update(viewState: ViewState.idle);
        return true;
      }

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
      return false;
    }

    return false;
  }

}


