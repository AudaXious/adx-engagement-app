import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class JoinSpaceUseCase {
  Future<dynamic> joinSpace(String spaceId);

}
class JoinSpaceUseCaseImpl extends JoinSpaceUseCase {
  final SpacesRepository spacesRepository;

  JoinSpaceUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> joinSpace(String spaceId) async {
    return await spacesRepository.joinSpace(spaceId);
  }
}

final joinSpaceUseCaseProvider = Provider<JoinSpaceUseCase>((ref) {
  return JoinSpaceUseCaseImpl(ref.read(spacesRepositoryProvider));
});