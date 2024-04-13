import 'package:audaxious/data/repository/auth_repository_impl.dart';
import 'package:audaxious/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class WalletLoginUseCase {
  Future<Map<String, dynamic>> walletLogin(walletId);

}
class WalletLoginUseCaseImpl extends WalletLoginUseCase {
  final AuthRepository authRepository;

  WalletLoginUseCaseImpl(this.authRepository);

  @override
  Future<Map<String, dynamic>> walletLogin(walletId) async {
    return await authRepository.walletLogin(walletId);
  }
}

final walletLoginUseCaseProvider = Provider<WalletLoginUseCase>((ref) {
  return WalletLoginUseCaseImpl(ref.read(authRepositoryProvider));
});