import 'package:audaxious/data/repository/auth_repository_impl.dart';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class LoginUseCase {
  Future<Map<String, dynamic>> login(email, password);

}
class LoginUseCaseImpl extends LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCaseImpl(this.authRepository);

  @override
  Future<Map<String, dynamic>> login(email, password) async {
    return await authRepository.login(email, password);
  }
}

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCaseImpl(ref.read(authRepositoryProvider));
});