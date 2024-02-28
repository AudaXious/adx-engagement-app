
import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/usecases/feeds/feeds_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/enums/view_state.dart';
import '../../../domain/usecases/feeds/feeds_usecase_provider.dart';
import '../../screens/main/home_state.dart';
import '../../screens/posts/post_details_state.dart';

class PostsViewModel extends StateNotifier<PostDetailsState> {
  FeedsUseCase feedsUseCase;

  PostsViewModel({
    required this.feedsUseCase,
  }) : super (PostDetailsState.initial()) {
    getFeeds();
  }

  static final notifier =
  StateNotifierProvider<PostsViewModel, PostDetailsState>((ref) => PostsViewModel(
      feedsUseCase: ref.read(feedsUseCaseProvider),
  ));


  Future<void> getFeeds() async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await feedsUseCase.getFeeds();

      final data = response['tweets'];
      // final data = response;

      if (data != null) {
        if (data is List) {
          final List<Map<String, dynamic>> dataList = data.cast<Map<String, dynamic>>();

          final feeds = dataList.map((feedsData) => Feed.fromJson(feedsData)).toList();
          state = state.update(feeds: feeds);

        } else {
          print('Unexpected data format. Expected a list of orders.');
          state = state.update(viewState: ViewState.error);
          state = state.update(error: "Unexpected data format. Expected a list of orders");
        }
      }

      state = state.update(viewState: ViewState.idle);

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print(e.toString());
    }
  }

}


