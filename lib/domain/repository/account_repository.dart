import '../models/user.dart';

abstract class AccountRepository {
  Future<User?> getCurrentSavedUserProfile();
  Future<dynamic> getCurrentUserProfile();
}