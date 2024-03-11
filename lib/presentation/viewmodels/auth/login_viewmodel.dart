
import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/usecases/auth/login_usecase.dart';
import 'package:audaxious/domain/usecases/feeds/feeds_usecase.dart';
import 'package:audaxious/presentation/screens/auth/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../screens/main/home_state.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginUseCase loginUseCase;

  LoginViewModel({
    required this.loginUseCase,
  }) : super (LoginState.initial()) {
    // loginUser();
  }

  static final notifier =
  StateNotifierProvider<LoginViewModel, LoginState>((ref) => LoginViewModel(
      loginUseCase: ref.read(loginUseCaseProvider),
  ));

Future<void> loginUser(String email) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await loginUseCase.login(email);

      final data = response['data'];

      if (data != null) {
        print("data: $data");
        final user = User.fromJson(data);
        state = state.update(user: user);
      }

      state = state.update(viewState: ViewState.idle);

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

}


