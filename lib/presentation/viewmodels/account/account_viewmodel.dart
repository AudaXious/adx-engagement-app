
import 'package:audaxious/core/services/shared_preferences_services.dart';
import 'package:audaxious/domain/usecases/account/logout_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/usecases/account/user_usecase.dart';
import '../../screens/account/account_state.dart';

class AccountViewModel extends StateNotifier<AccountState> {
  LogoutUseCase logoutUseCase;
  UserUseCase userUseCase;

  AccountViewModel({
    required this.logoutUseCase,
    required this.userUseCase,
  }) : super (AccountState.initial()) {
    updateLoginStatus();
    // getCurrentSavedUserProfile();
  }

  static final notifier =
  StateNotifierProvider<AccountViewModel, AccountState>((ref) => AccountViewModel(
      logoutUseCase: ref.read(logoutUseCaseProvider),
      userUseCase: ref.read(userUseCaseProvider),
  ));

  Future<bool> logoutUser() async {
    state = state.update(logoutViewState: ViewState.loading);
    await Future.delayed(const Duration(milliseconds: 2000));
    try {
      await logoutUseCase.logout();
      state = state.update(logoutViewState: ViewState.idle);
      return true;

    } catch (e) {
      state = state.update(logoutViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
      return false;
    }
 }

  Future<void> updateLoginStatus() async {
  try {
    final isLoggedIn = await SharedPreferencesServices.getIsLoggedIn();
    state = state.update(isLoggedIn: isLoggedIn);
    print(isLoggedIn);
  }catch (e) {
    state = state.update(logoutViewState: ViewState.error);
    state = state.update(error: e.toString());
    print("View model error: ${e.toString()}");
  }
 }

  Future<void> getCurrentSavedUserProfile() async {
    state = state.update(profileViewState: ViewState.loading);
    try {
      final response = await userUseCase.getCurrentSavedUserProfile();
      print(response);

    }catch (e) {
      state = state.update(profileViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }


}


