import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class SpaceDetailUseCase {
  Future<dynamic> getSpaceDetails(String spaceId);

}
class SpaceDetailsUseCaseImpl extends SpaceDetailUseCase {
  final SpacesRepository spacesRepository;

  SpaceDetailsUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> getSpaceDetails(String spaceId) async {
    return await spacesRepository.getSpaceDetails(spaceId);
  }
}

final spaceDetailsUseCaseProvider = Provider<SpaceDetailUseCase>((ref) {
  return SpaceDetailsUseCaseImpl(ref.read(spacesRepositoryProvider));
});