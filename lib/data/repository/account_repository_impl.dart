import 'dart:convert';
import 'package:audaxious/domain/repository/account_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/shared_preferences_services.dart';
import '../../domain/models/user.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<User?> getCurrentSavedUser() async {
    try {
      String? userJson = await SharedPreferencesServices().getCurrentSavedUser("user");
      if (userJson != null) {
        dynamic userMap = json.decode(userJson);
        User user = User.fromJson(userMap);
        return user;
      }
    } catch (e) {
      print("Error loading user data: $e");
    }

    return null;
  }
}

final accountRepositoryProvider = Provider<AccountRepository>((ref){
  return AccountRepositoryImpl();
});