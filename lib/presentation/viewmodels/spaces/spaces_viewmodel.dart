
import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/domain/usecases/spaces/join_space_usecase.dart';
import 'package:audaxious/domain/usecases/spaces/space_detail_usecase.dart';
import 'package:audaxious/domain/usecases/spaces/spaces_usecase.dart';
import 'package:audaxious/presentation/screens/main/spaces_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/usecases/spaces/user_spaces_usecase.dart';

class SpacesViewModel extends StateNotifier<SpacesState> {
  SpacesUseCase spacesUseCase;
  SpaceDetailUseCase spaceDetailUseCase;
  UserSpacesUseCase userSpacesUseCase;
  JoinSpaceUseCase joinSpacesUseCase;

  SpacesViewModel({
    required this.spacesUseCase,
    required this.userSpacesUseCase,
    required this.spaceDetailUseCase,
    required this.joinSpacesUseCase,
  }) : super (SpacesState.initial()) {
    getSpaces();
  }

  static final notifier =
  StateNotifierProvider<SpacesViewModel, SpacesState>((ref) => SpacesViewModel(
      spacesUseCase: ref.read(spacesUseCaseProvider),
      userSpacesUseCase: ref.read(userSpacesUseCaseProvider),
      spaceDetailUseCase: ref.read(spaceDetailsUseCaseProvider),
      joinSpacesUseCase: ref.read(joinSpaceUseCaseProvider),
  ));

  Future<void> getSpaces() async {
    state = state.update(spaceViewState: ViewState.loading);
    try {
      final response = await spacesUseCase.getSpaces();
      final data = response['data'];

      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        final spaces = dataList.map((spacesData) => Space.fromJson(spacesData)).toList();
        state = state.update(spaces: spaces);
      }else {
        print('Unexpected data format. Expected a list of spaces.');
        state = state.update(spaceViewState: ViewState.error);
        state = state.update(error: "Unexpected data format. Expected a list of spaces");
      }

      state = state.update(spaceViewState: ViewState.idle);

    } catch (e) {
      state = state.update(spaceViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

  Future<void> getUserSpaces() async {
    state = state.update(spaceViewState: ViewState.loading);
    try {
      final response = await userSpacesUseCase.getUserSpaces();
      final data = response['data'];

      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        final spaces = dataList.map((spacesData) => Space.fromJson(spacesData)).toList();
        state = state.update(spaces: spaces);
      }else {
        print('Unexpected data format. Expected a list of spaces.');
        state = state.update(spaceViewState: ViewState.error);
        state = state.update(error: "Unexpected data format. Expected a list of spaces");
      }

      state = state.update(spaceViewState: ViewState.idle);

    } catch (e) {
      state = state.update(spaceViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

  Future<void> getSpaceDetail(String spaceId) async {
    state = state.update(spaceViewState: ViewState.loading);
    try {
      final response = await spaceDetailUseCase.getSpaceDetails(spaceId);
      final data = response['data'];

      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        final spaces = dataList.map((spacesData) => Space.fromJson(spacesData)).toList();
        state = state.update(spaces: spaces);
      }else {
        print('Unexpected data format. Expected a list of spaces.');
        state = state.update(spaceViewState: ViewState.error);
        state = state.update(error: "Unexpected data format. Expected a list of spaces");
      }

      state = state.update(spaceViewState: ViewState.idle);

    } catch (e) {
      state = state.update(spaceViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }

  Future<bool> joinSpace(String spaceId) async {
    state = state.update(joinSpaceViewState: ViewState.loading);
    try {
      final response = await joinSpacesUseCase.joinSpace(spaceId);
      final data = response['data'];
      final message = response['message'];
      print(message);

      state = state.update(joinSpaceViewState: ViewState.idle);
      state = state.update(message: message);

      return true;

    } catch (e) {
      state = state.update(joinSpaceViewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
      return false;
    }
  }
}


