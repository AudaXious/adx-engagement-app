import 'package:audaxious/data/repository/auth_repository_impl.dart';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class VerifyTwitterUseCase {
  Future<Map<String, dynamic>> verifyTwitter(url);

}
class VerifyTwitterUseCaseImpl extends VerifyTwitterUseCase {
  final AuthRepository authRepository;

  VerifyTwitterUseCaseImpl(this.authRepository);

  @override
  Future<Map<String, dynamic>> verifyTwitter(url) async {
    return await authRepository.verifyTwitter(url);
  }
}

final verifyTwitterUseCaseProvider = Provider<VerifyTwitterUseCase>((ref) {
  return VerifyTwitterUseCaseImpl(ref.read(authRepositoryProvider));
});