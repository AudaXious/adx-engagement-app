
import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/usecases/auth/login_usecase.dart';
import 'package:audaxious/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:audaxious/domain/usecases/feeds/feeds_usecase.dart';
import 'package:audaxious/presentation/screens/auth/login_state.dart';
import 'package:audaxious/presentation/screens/auth/otp_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../screens/main/home_state.dart';
import '../../widgets/custom_toast.dart';

class VerifyOTPViewModel extends StateNotifier<OTPState> {
  VerifyOTPUseCase verifyOTPUseCase;

  VerifyOTPViewModel({
    required this.verifyOTPUseCase,
  }) : super (OTPState.initial());

  static final notifier =
  StateNotifierProvider<VerifyOTPViewModel, OTPState>((ref) => VerifyOTPViewModel(
      verifyOTPUseCase: ref.read(verifyOTPUseCaseProvider),
  ));

Future<void> verifyUser(BuildContext context,String email, String otp) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await verifyOTPUseCase.verifyOTP(email, otp);
      print(response);
      final data = response['data'];
      final error = response['error'];

      if(error != null) {
        CustomToast.show(
          context: context,
          title: "Error",
          description: error,
          type: ToastificationType.error,
        );
      }

      if (data != null) {
        final user = User.fromJson(data);
        state = state.update(user: user);
      }

      state = state.update(viewState: ViewState.idle);

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
    }
  }

}


