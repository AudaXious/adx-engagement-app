
import 'package:audaxious/core/services/shared_preferences_services.dart';
import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/domain/usecases/spaces/join_space_usecase.dart';
import 'package:audaxious/domain/usecases/spaces/space_detail_usecase.dart';
import 'package:audaxious/domain/usecases/spaces/spaces_usecase.dart';
import 'package:audaxious/presentation/screens/main/spaces_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/usecases/spaces/user_created_spaces_usecase.dart';
import '../../../domain/usecases/spaces/user_joined_spaces_usecase.dart';
import '../../widgets/alerts/custom_toast.dart';

class SpacesViewModel extends StateNotifier<SpacesState> {
  SpacesUseCase spacesUseCase;
  SpaceDetailUseCase spaceDetailUseCase;
  UserCreatedSpacesUseCase userCreatedSpacesUseCase;
  UserJoinedSpacesUseCase userJoinedSpacesUseCase;
  JoinSpaceUseCase joinSpacesUseCase;

  SpacesViewModel({
    required this.spacesUseCase,
    required this.userCreatedSpacesUseCase,
    required this.spaceDetailUseCase,
    required this.userJoinedSpacesUseCase,
    required this.joinSpacesUseCase,
  }) : super (SpacesState.initial()) {
    getSpaces();
  }

  static final notifier =
  StateNotifierProvider<SpacesViewModel, SpacesState>((ref) => SpacesViewModel(
      spacesUseCase: ref.read(spacesUseCaseProvider),
      userCreatedSpacesUseCase: ref.read(userCreatedSpacesUseCaseProvider),
      spaceDetailUseCase: ref.read(spaceDetailsUseCaseProvider),
      userJoinedSpacesUseCase: ref.read(userJoinedSpacesUseCaseProvider),
      joinSpacesUseCase: ref.read(joinSpaceUseCaseProvider),
  ));

  Future<void> getSpaces() async {
    state = state.update(spaceViewState: ViewState.loading);
    try {
      final requiresAuthorization = await SharedPreferencesServices.getIsLoggedIn();
      final response = await spacesUseCase.getSpaces(requiresAuthorization);
      final data = response['data'];

      if (data != null && data is List) {
        final List dataList = data.cast<dynamic>();

        final spaces = dataList.map((spacesData) => Space.fromJson(spacesData)).toList();
        state = state.update(spaces: spaces);
        for (int i = 0; i < spaces.length; i++) {
          print(spaces[i].isMember);
        }
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

  Future<void> getUserCreatedSpaces() async {
    state = state.update(spaceViewState: ViewState.loading);
    try {
      final response = await userCreatedSpacesUseCase.getUserCreatedSpaces();
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

  Future<void> getUserJoinedSpaces() async {
    state = state.update(spaceViewState: ViewState.loading);
    try {
      final response = await userJoinedSpacesUseCase.getUserJoinedSpaces();
      final data = response['data'];
      print(data);

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

  Future<bool> joinSpace(String spaceId, BuildContext context) async {
    state = state.update(joinSpaceViewState: ViewState.loading);
    try {
      final response = await joinSpacesUseCase.joinSpace(spaceId);
      final message = response['message'];

      state = state.update(message: message);
      state = state.update(joinSpaceViewState: ViewState.idle);

      CustomToast.show(
        context: context,
        title: "Success",
        description: message,
        type: ToastificationType.success,
      );

      return true;

    } catch (e) {
      state = state.update(error: e.toString());
      state = state.update(joinSpaceViewState: ViewState.error);
      CustomToast.show(
        context: context,
        title: "Error",
        description: e.toString(),
        type: ToastificationType.error,
      );
      print("View model error: ${e.toString()}");
      return false;
    }
  }

  void filterSpacesByTitle(String query) {
    if (query.isEmpty) {
      state = state.update(filteredSpaces: state.spaces);
    } else {
      final filteredSpaces = state.spaces?.where((space) =>
          space.title!.toLowerCase().contains(query.toLowerCase())).toList();

      if (filteredSpaces != null && filteredSpaces.isNotEmpty) {
        state = state.update(filteredSpaces: filteredSpaces);
      } else {
        state = state.update(filteredSpaces: []);
      }
    }
  }

}


