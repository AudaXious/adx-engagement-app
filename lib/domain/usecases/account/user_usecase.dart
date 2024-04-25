import 'package:audaxious/domain/repository/account_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/account_repository_impl.dart';
import '../../models/user.dart';
abstract class UserUseCase {
  Future<User?> getCurrentSavedUser();
  Future<dynamic> getCurrentSavedUserProfile();
}
class UserUseCaseImpl extends UserUseCase {
  final AccountRepository accountRepository;

  UserUseCaseImpl(this.accountRepository);

  @override
  Future<User?> getCurrentSavedUser() async  {
    return await accountRepository.getCurrentSavedUserProfile();
  }

  @override
  Future<dynamic> getCurrentSavedUserProfile() async {
    return accountRepository.getCurrentUserProfile();
  }

}

final userUseCaseProvider = Provider<UserUseCase>((ref) {
  return UserUseCaseImpl(ref.read(accountRepositoryProvider));
});