import '../entities/login.dart';

abstract class AuthRepository{
  Future<Login> loginWithEmailAndPassword({required String email,required String password});
  Future<int> forgetPassword({required String email});
  Future<void> verifyOTP({required String otp,required String userId});
  Future<void> resetPassword({required String newPassword,required String confirmPassword,required String userId});

  Future<Login> createAccountWithEmailAndPassword({required String firstName,required String lastName,required String email,required String password});
  Future<Login> loginWithGoogle();
  Future<Login> loginWithApple();
  Future<void> logout();


}