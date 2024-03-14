
import 'package:audaxious/domain/models/feed.dart';
import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/domain/usecases/feeds/feeds_usecase.dart';
import 'package:audaxious/domain/usecases/spaces/spaces_usecase.dart';
import 'package:audaxious/presentation/screens/main/spaces_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../screens/main/home_state.dart';

class SpacesViewModel extends StateNotifier<SpacesState> {
  SpacesUseCase spacesUseCase;

  SpacesViewModel({
    required this.spacesUseCase,
  }) : super (SpacesState.initial()) {
    getFeeds();
  }

  static final notifier =
  StateNotifierProvider<SpacesViewModel, SpacesState>((ref) => SpacesViewModel(
      spacesUseCase: ref.read(spacesUseCaseProvider),
  ));

Future<void> getFeeds() async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await spacesUseCase.getSpaces();

      final List<Map<String, dynamic>> dataList = response.cast<Map<String, dynamic>>();
      final spaces = dataList
          .map((spacesData) => Space.fromJson(spacesData))
          .toList();
      state = state.update(spaces: spaces);
      state = state.update(viewState: ViewState.idle);

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

}


