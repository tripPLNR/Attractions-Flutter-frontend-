import '../entities/login.dart';

abstract class AuthRepository{
  Future<Login> loginWithEmailAndPassword({required String email,required String password});
  Future<bool> forgetPassword({required String email});
  Future<Login> createAccountWithEmailAndPassword({required String firstName,required String lastName,required String email,required String password});
  Future<Login> loginWithGoogle();
  Future<Login> loginWithApple();
  Future<void> logout();


}