import 'package:audaxious/domain/repository/feeds_repository.dart';

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