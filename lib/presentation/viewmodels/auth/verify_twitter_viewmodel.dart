
import 'package:audaxious/domain/usecases/auth/login_usecase.dart';
import 'package:audaxious/domain/usecases/auth/verify_twitter_usecase.dart';
import 'package:audaxious/presentation/screens/auth/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../screens/auth/verify_twitter_state.dart';

class VerifyTwitterViewModel extends StateNotifier<VerifyTwitterState> {
  VerifyTwitterUseCase verifyTwitterUseCase;

  VerifyTwitterViewModel({
    required this.verifyTwitterUseCase,
  }) : super (VerifyTwitterState.initial());

  static final notifier =
  StateNotifierProvider<VerifyTwitterViewModel, VerifyTwitterState>((ref) => VerifyTwitterViewModel(
      verifyTwitterUseCase: ref.read(verifyTwitterUseCaseProvider),
  ));

Future<bool> verifyTwitter(String url) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await verifyTwitterUseCase.verifyTwitter(url);
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


