
import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/usecases/feeds/feeds_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../screens/main/home_state.dart';

class LoginViewModel extends StateNotifier<HomeState> {
  FeedsUseCase feedsUseCase;

  LoginViewModel({
    required this.feedsUseCase,
  }) : super (HomeState.initial()) {
    getFeeds();
  }

  static final notifier =
  StateNotifierProvider<LoginViewModel, HomeState>((ref) => LoginViewModel(
      feedsUseCase: ref.read(feedsUseCaseProvider),
  ));

Future<void> getFeeds() async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await feedsUseCase.getFeeds();

      final List<Map<String, dynamic>> dataList = response.cast<Map<String, dynamic>>();

      final feeds = dataList
          .map((feedsData) => Feed.fromJson(feedsData))
          .toList();
      state = state.update(feeds: feeds);

      state = state.update(viewState: ViewState.idle);

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

}


