
import 'package:audaxious/domain/models/space.dart';
import 'package:audaxious/domain/models/space_details.dart';
import 'package:audaxious/domain/usecases/spaces/space_detail_usecase.dart';
import 'package:audaxious/domain/usecases/spaces/spaces_usecase.dart';
import 'package:audaxious/presentation/screens/main/spaces_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/view_state.dart';
import '../../../domain/usecases/spaces/user_spaces_usecase.dart';
import '../../screens/spaces/space_detail_state.dart';

class SpacesDetailsViewModel extends StateNotifier<SpaceDetailState> {
  SpaceDetailUseCase spaceDetailUseCase;
  // String spaceId;
  SpacesDetailsViewModel({
    required this.spaceDetailUseCase,
    // required this.spaceId
  }) : super (SpaceDetailState.initial()) {
    // getSpaceDetail(spaceId);
  }

  static final notifier =
  StateNotifierProvider<SpacesDetailsViewModel, SpaceDetailState>((ref) => SpacesDetailsViewModel(
      spaceDetailUseCase: ref.read(spaceDetailsUseCaseProvider),
  ));


  Future<void> getSpaceDetail(String spaceId) async {
    state = state.update(viewState: ViewState.loading);
    try {
      final response = await spaceDetailUseCase.getSpaceDetails(spaceId);
      final data = response['data'];
      print(data);
      final space = SpaceDetails.fromJson(data);

      state = state.update(spaceDetails: space);
      state = state.update(viewState: ViewState.idle);

    } catch (e) {
      state = state.update(viewState: ViewState.error);
      state = state.update(error: e.toString());
      print("View model error: ${e.toString()}");
    }
  }
}


