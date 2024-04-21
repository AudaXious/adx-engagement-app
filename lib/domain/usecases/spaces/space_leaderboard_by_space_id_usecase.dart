import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class SpaceLeaderBoardBySpaceIdUseCase {
  Future<dynamic> getLeaderBoardBySpaceId(String spaceId);

}
class SpaceLeaderBoardBySpaceIdUseCaseImpl extends SpaceLeaderBoardBySpaceIdUseCase {
  final SpacesRepository spacesRepository;

  SpaceLeaderBoardBySpaceIdUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> getLeaderBoardBySpaceId(String spaceId) async {
    return await spacesRepository.getLeaderBoardBySpaceId(spaceId);
  }
}

final spaceLeaderBoardBySpaceIdRepositoryProvider = Provider<SpaceLeaderBoardBySpaceIdUseCase>((ref) {
  return SpaceLeaderBoardBySpaceIdUseCaseImpl(ref.read(spacesRepositoryProvider));
});