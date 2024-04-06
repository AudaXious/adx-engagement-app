import 'package:audaxious/data/repository/auth_repository_impl.dart';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class LogoutUseCase {
  Future<void> logout();

}
class LogoutUseCaseImpl extends LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCaseImpl(this.authRepository);

  @override
  Future<void> logout() async {
    return await authRepository.logoutUser();
  }
}

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCaseImpl(ref.read(authRepositoryProvider));
});