import 'package:audaxious/data/repository/feeds_repository_impl.dart';
import 'package:audaxious/domain/repository/feeds_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedsRepositoryProvider = Provider<FeedsRepository>((ref) {
  return FeedsRepositoryImpl();
});
