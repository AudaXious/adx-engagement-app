import 'package:audaxious/data/repository/spaces_repository_impl.dart';
import 'package:audaxious/domain/repository/spaces_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
abstract class CampaignsBySpaceIdUseCase {
  Future<dynamic> getCampaignsBySpaceId(String spaceId);

}
class CampaignsBySpaceIdUseCaseImpl extends CampaignsBySpaceIdUseCase {
  final SpacesRepository spacesRepository;

  CampaignsBySpaceIdUseCaseImpl(this.spacesRepository);

  @override
  Future<dynamic> getCampaignsBySpaceId(String spaceId) async {
    return await spacesRepository.getCampaignsBySpaceId(spaceId);
  }
}

final campaignsBySpaceIdRepositoryProvider = Provider<CampaignsBySpaceIdUseCase>((ref) {
  return CampaignsBySpaceIdUseCaseImpl(ref.read(spacesRepositoryProvider));
});