import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class UserCreatedSpacesUseCase {
  Future<dynamic> getUserCreatedSpaces();

}
class UserCreatedSpacesUseCaseImpl extends UserCreatedSpacesUseCase {
  final SpacesRepository spacesRepository;

  UserCreatedSpacesUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> getUserCreatedSpaces() async {
    return await spacesRepository.getUserCreatedSpaces();
  }
}

final userCreatedSpacesUseCaseProvider = Provider<UserCreatedSpacesUseCase>((ref) {
  return UserCreatedSpacesUseCaseImpl(ref.read(spacesRepositoryProvider));
});