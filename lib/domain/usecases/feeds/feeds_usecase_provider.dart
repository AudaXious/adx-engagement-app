import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/providers/feeds_provider.dart';
import 'feeds_usecase.dart';

final feedsUseCaseProvider = Provider<FeedsUseCase>((ref) {
  return FeedsUseCaseImpl(ref.read(feedsRepositoryProvider));
});