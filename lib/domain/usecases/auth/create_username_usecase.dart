import 'package:audaxious/data/repository/auth_repository_impl.dart';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class CreateUsernameUseCase {
  Future<Map<String, dynamic>> createUsername(username);

}
class CreateUsernameUseCaseImpl extends CreateUsernameUseCase {
  final AuthRepository authRepository;

  CreateUsernameUseCaseImpl(this.authRepository);

  @override
  Future<Map<String, dynamic>> createUsername(username) async {
    return await authRepository.createUsername(username);
  }
}

final createUsernameUseCaseProvider = Provider<CreateUsernameUseCase>((ref) {
  return CreateUsernameUseCaseImpl(ref.read(authRepositoryProvider));
});