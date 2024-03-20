abstract class SpacesRepository {
  Future<dynamic> getSpaces();
  Future<dynamic> getUserSpaces();
  Future<dynamic> getSpaceDetails(String spaceId);
}
