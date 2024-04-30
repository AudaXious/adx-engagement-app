import 'package:audaxious/domain/repository/campaigns_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repository/campaigns_repository_impl.dart';
abstract class CampaignsUseCase {
  Future<dynamic> getCampaigns();

}
class CampaignsUseCaseImpl extends CampaignsUseCase {
  final CampaignsRepository campaignsRepository;

  CampaignsUseCaseImpl(this.campaignsRepository);

  @override
  Future<dynamic> getCampaigns() async {
    return await campaignsRepository.getCampaigns();
  }
}

final campaignsUseCaseProvider = Provider<CampaignsUseCase>((ref) {
  return CampaignsUseCaseImpl(ref.read(campaignsRepositoryProvider));
});