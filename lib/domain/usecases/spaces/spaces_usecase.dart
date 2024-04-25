import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class SpacesUseCase {
  Future<dynamic> getSpaces(bool requiresAuthorization);

}
class SpacesUseCaseImpl extends SpacesUseCase {
  final SpacesRepository spacesRepository;

  SpacesUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> getSpaces(bool requiresAuthorization) async {
    return await spacesRepository.getSpaces(requiresAuthorization);
  }
}

final spacesUseCaseProvider = Provider<SpacesUseCase>((ref) {
  return SpacesUseCaseImpl(ref.read(spacesRepositoryProvider));
});