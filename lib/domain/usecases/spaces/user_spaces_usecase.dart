import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/feeds_repository.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repository/feeds_repository_impl.dart';
abstract class UserSpacesUseCase {
  Future<dynamic> getUserSpaces();

}
class SpacesUseCaseImpl extends UserSpacesUseCase {
  final SpacesRepository spacesRepository;

  SpacesUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> getUserSpaces() async {
    return await spacesRepository.getUserSpaces();
  }
}

final userSpacesUseCaseProvider = Provider<UserSpacesUseCase>((ref) {
  return SpacesUseCaseImpl(ref.read(spacesRepositoryProvider));
});