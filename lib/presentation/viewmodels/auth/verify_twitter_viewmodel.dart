
import 'package:audaxious/domain/usecases/auth/verify_twitter_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../screens/auth/verify_twitter_state.dart';
import '../../widgets/alerts/custom_toast.dart';

class VerifyTwitterViewModel extends StateNotifier<VerifyTwitterState> {
  VerifyTwitterUseCase verifyTwitterUseCase;

  VerifyTwitterViewModel({
    required this.verifyTwitterUseCase,
  }) : super (VerifyTwitterState.initial());

  static final notifier =
  StateNotifierProvider<VerifyTwitterViewModel, VerifyTwitterState>((ref) => VerifyTwitterViewModel(
      verifyTwitterUseCase: ref.read(verifyTwitterUseCaseProvider),
  ));

Future<bool> verifyTwitter(String url, BuildContext context) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await verifyTwitterUseCase.verifyTwitter(url.trim());
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
      CustomToast.show(
        context: context,
        title: "Error",
        description: e.toString(),
        type: ToastificationType.error,
      );
      print("View model error: ${e.toString()}");
      return false;
    }

    return false;
  }

}


