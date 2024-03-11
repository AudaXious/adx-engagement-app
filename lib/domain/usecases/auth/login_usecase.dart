import 'package:audaxious/data/repository/auth_repository_impl.dart';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class LoginUseCase {
  Future<Map<String, dynamic>> login(email);

}
class LoginUseCaseImpl extends LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCaseImpl(this.authRepository);

  @override
  Future<Map<String, dynamic>> login(email) async {
    return await authRepository.login(email);
  }
}

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCaseImpl(ref.read(authRepositoryProvider));
});