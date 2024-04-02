abstract class SpacesRepository {
  Future<dynamic> getSpaces();
  Future<dynamic> getUserCreatedSpaces();
  Future<dynamic> getUserJoinedSpaces();
  Future<dynamic> getSpaceDetails(String spaceId);
  Future<dynamic> getCampaignsBySpaceId(String spaceId);
  Future<dynamic> joinSpace(String spaceId);
}
