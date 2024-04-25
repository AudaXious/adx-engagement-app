abstract class SpacesRepository {
  Future<dynamic> getSpaces(bool requiresAuthorization);
  Future<dynamic> getUserCreatedSpaces();
  Future<dynamic> getUserJoinedSpaces();
  Future<dynamic> getSpaceDetails(String spaceId);
  Future<dynamic> getCampaignsBySpaceId(String spaceId);
  Future<dynamic> getLeaderBoardBySpaceId(String spaceId);
  Future<dynamic> joinSpace(String spaceId);
}
