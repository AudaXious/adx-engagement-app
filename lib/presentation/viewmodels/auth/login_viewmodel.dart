
import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/usecases/auth/login_usecase.dart';
import 'package:audaxious/domain/usecases/feeds/feeds_usecase.dart';
import 'package:audaxious/presentation/screens/auth/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/models/user.dart';
import '../../screens/main/home_state.dart';
import '../../widgets/custom_toast.dart';

class LoginViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  bool isLoading = false;
  bool isSuccessful = false;
  late User? user;
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  LoginViewModel({required this.ref});

  Future<void> loginUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await ref
          .watch(loginUseCaseProvider)
          .login(emailCtr.text.toString());

      final data = response['data'];
      final message = response['message'];

      if (data != null) {
        user = User.fromJson(data);
        isSuccessful = true;
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

final loginViewModelProvider =
ChangeNotifierProvider<LoginViewModel>((ref) => LoginViewModel(ref: ref));

