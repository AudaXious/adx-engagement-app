
import 'package:audaxious/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:audaxious/presentation/screens/auth/verify_otp_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';

class VerifyOTPViewModel extends StateNotifier<VerifyOTPState> {
  VerifyOTPUseCase verifyOTPUseCase;

  VerifyOTPViewModel({
    required this.verifyOTPUseCase,
  }) : super (VerifyOTPState.initial());

  static final notifier =
  StateNotifierProvider<VerifyOTPViewModel, VerifyOTPState>((ref) => VerifyOTPViewModel(
    verifyOTPUseCase: ref.read(verifyOTPUseCaseProvider),
  ));

  Future<bool> verifyOTP(String email,String otp) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await verifyOTPUseCase.verifyOTP(email, otp);
      final success = response['success'];
      final message = response['message'];
      final data = response['data'];

      state = state.update(message: message);

      if (success != null && success == true) {
        if (data != null) {
          final user = User.fromJson(data);
          print(user.username);
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

