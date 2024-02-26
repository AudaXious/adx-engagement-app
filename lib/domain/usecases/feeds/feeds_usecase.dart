import 'package:audaxious/data/providers/feeds_provider.dart';
import 'package:audaxious/domain/repository/feeds_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FeedsUseCase {
  Future<Map<String, dynamic>> getFeeds();

}
class FeedsUseCaseImpl extends FeedsUseCase {
  final FeedsRepository feedsRepository;

  FeedsUseCaseImpl(this.feedsRepository);

  @override
  Future<Map<String, dynamic>> getFeeds() async {
    return await feedsRepository.getFeeds();
  }
}

final feedsUseCaseProvider = Provider<FeedsUseCase>((ref) {
  return FeedsUseCaseImpl(ref.read(feedsRepositoryProvider));
});