
import 'package:audaxious/domain/usecases/auth/create_username_usecase.dart';
import 'package:audaxious/presentation/screens/auth/create_username_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../widgets/alerts/custom_toast.dart';

class CreateUsernameViewModel extends StateNotifier<CreateUsernameState> {
  CreateUsernameUseCase createUsernameUseCase;

  CreateUsernameViewModel({
    required this.createUsernameUseCase,
  }) : super (CreateUsernameState.initial());

  static final notifier =
  StateNotifierProvider<CreateUsernameViewModel, CreateUsernameState>((ref) => CreateUsernameViewModel(
      createUsernameUseCase: ref.read(createUsernameUseCaseProvider),
  ));

  Future<bool> createUsername(BuildContext context, String username) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await createUsernameUseCase.createUsername(username.trim());
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


