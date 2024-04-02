import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class UserSpacesUseCase {
  Future<dynamic> getUserCreatedSpaces();

}
class SpacesUseCaseImpl extends UserSpacesUseCase {
  final SpacesRepository spacesRepository;

  SpacesUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> getUserCreatedSpaces() async {
    return await spacesRepository.getUserCreatedSpaces();
  }
}

final userCreatedSpacesUseCaseProvider = Provider<UserSpacesUseCase>((ref) {
  return SpacesUseCaseImpl(ref.read(spacesRepositoryProvider));
});