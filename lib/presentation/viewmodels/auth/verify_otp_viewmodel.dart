
import 'package:audaxious/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:audaxious/presentation/screens/auth/otp_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../widgets/custom_toast.dart';

class VerifyOTPViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  bool isLoading = false;
  bool isSuccessful = false;

  VerifyOTPViewModel({required this.ref});

  Future<void> verifyOTPForSignIn(BuildContext context, String email, String otp) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await ref
          .watch(verifyOTPUseCaseProvider)
          .verifyOTP(email, otp);

      final data = response['data'];
      final message = response['message'];

      if (data != null) {
        isSuccessful = true;
      }

      if (message != null) {
        CustomToast.show(
          context: context,
          title: 'Success',
          description: message,
          type: ToastificationType.success,
        );
      }

      isLoading = false;
      notifyListeners();

    } catch (e) {
      isLoading = false;
      notifyListeners();

      CustomToast.show(
        context: context,
        title: 'Error',
        description: e.toString(),
        type: ToastificationType.error,
      );

      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}

final verifyOTPViewModelProvider =
ChangeNotifierProvider<VerifyOTPViewModel>(
        (ref) => VerifyOTPViewModel(ref: ref));

