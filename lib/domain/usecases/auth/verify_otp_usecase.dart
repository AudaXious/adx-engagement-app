import 'package:audaxious/data/repository/auth_repository_impl.dart';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class VerifyOTPUseCase {
  Future<Map<String, dynamic>> verifyOTP(email, otp);

}
class VerifyOTPUseCaseImpl extends VerifyOTPUseCase {
  final AuthRepository authRepository;

  VerifyOTPUseCaseImpl(this.authRepository);

  @override
  Future<Map<String, dynamic>> verifyOTP(email, otp) async {
    return await authRepository.login(email, otp);
  }
}

final verifyOTPUseCaseProvider = Provider<VerifyOTPUseCase>((ref) {
  return VerifyOTPUseCaseImpl(ref.read(authRepositoryProvider));
});