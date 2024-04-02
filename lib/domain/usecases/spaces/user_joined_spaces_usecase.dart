import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class UserJoinedSpacesUseCase {
  Future<dynamic> getUserJoinedSpaces();

}
class UserJoinedSpacesUseCaseImpl extends UserJoinedSpacesUseCase {
  final SpacesRepository spacesRepository;

  UserJoinedSpacesUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> getUserJoinedSpaces() async {
    return await spacesRepository.getUserJoinedSpaces();
  }
}

final userJoinedSpacesUseCaseProvider = Provider<UserJoinedSpacesUseCase>((ref) {
  return UserJoinedSpacesUseCaseImpl(ref.read(spacesRepositoryProvider));
});