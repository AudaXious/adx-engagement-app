
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

Future<void> loginUser(BuildContext context, String email) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await loginUseCase.login(email);
      final success = response['success'];
      final error = response['error'];
      final data = response['data'];
      print(error);
      print(success);

      if (data != null) {
        final user = User.fromJson(data);
        state = state.update(user: user);
      }

      state = state.update(viewState: ViewState.idle);

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
      CustomToast.show(
        context: context,
        title: "Error",
        description: e.toString(),
        type: ToastificationType.error,
      );
    }
  }

  // Future<bool> login(BuildContext context, String email) async {
  //
  // }

}


