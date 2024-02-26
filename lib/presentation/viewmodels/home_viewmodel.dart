
import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/usecases/feeds/feeds_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/view_state.dart';
import '../screens/main/home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  FeedsUseCase feedsUseCase;

  HomeViewModel({
    required this.feedsUseCase,
  }) : super (HomeState.initial()) {
    getOrderHistory();
  }

  static final notifier =
  StateNotifierProvider<HomeViewModel, HomeState>((ref) => HomeViewModel(
      feedsUseCase: ref.read(feedsUseCaseProvider),
  ));


  Future<void> getOrderHistory() async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await feedsUseCase.getFeeds();

      final data = response['data'];

      if (data != null) {
        if (data is List) {
          final List<Map<String, dynamic>> dataList = data.cast<Map<String, dynamic>>();

          final feeds = dataList.map((orderData) => Feed.fromJson(orderData)).toList();
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
    }
  }

}


