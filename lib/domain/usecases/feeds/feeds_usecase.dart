import 'package:audaxious/domain/repository/feeds_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repository/feeds_repository_impl.dart';
abstract class FeedsUseCase {
  Future<List<dynamic>> getFeeds();

}
class FeedsUseCaseImpl extends FeedsUseCase {
  final FeedsRepository feedsRepository;

  FeedsUseCaseImpl(this.feedsRepository);

  @override
  Future<List<dynamic>> getFeeds() async {
    return await feedsRepository.getFeeds();
  }
}

final feedsUseCaseProvider = Provider<FeedsUseCase>((ref) {
  return FeedsUseCaseImpl(ref.read(feedsRepositoryProvider));
});