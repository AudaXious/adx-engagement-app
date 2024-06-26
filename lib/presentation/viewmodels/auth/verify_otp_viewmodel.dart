
import 'package:audaxious/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:audaxious/presentation/screens/auth/verify_otp_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../widgets/alerts/custom_toast.dart';

class VerifyOTPViewModel extends StateNotifier<VerifyOTPState> {
  VerifyOTPUseCase verifyOTPUseCase;

  VerifyOTPViewModel({
    required this.verifyOTPUseCase,
  }) : super (VerifyOTPState.initial());

  static final notifier =
  StateNotifierProvider<VerifyOTPViewModel, VerifyOTPState>((ref) => VerifyOTPViewModel(
    verifyOTPUseCase: ref.read(verifyOTPUseCaseProvider),
  ));

  Future<User?> verifyOTP(String email,String otp, BuildContext context) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await verifyOTPUseCase.verifyOTP(email.trim(), otp.trim());
      final success = response['success'];
      final message = response['message'];
      final data = response['data'];

      state = state.update(message: message);

      if (success != null && success == true) {
        if (data != null) {
          final user = User.fromJson(data);
          state = state.update(user: user);
          state = state.update(viewState: ViewState.idle);
          return user;
        }

        state = state.update(viewState: ViewState.idle);
      }

    } catch (e) {

      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      CustomToast.show(
        context: context,
        title: "Error",
        description: e.toString(),
        type: ToastificationType.error,
      );
      print("View model error: ${e.toString()}");
      return null;
    }

    return null;
  }
}

