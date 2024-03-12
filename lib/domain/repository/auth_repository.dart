abstract class AuthRepository {
  Future<Map<String, dynamic>> login(String email);
  Future<Map<String, dynamic>> verifyOTPForSignIn(
    String email,
    String otp
  );
  Future<Map<String, dynamic>> createUsername(String username);
}