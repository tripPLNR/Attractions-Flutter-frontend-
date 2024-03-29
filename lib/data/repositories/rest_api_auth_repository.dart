import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:triplaner/data/models/login_json.dart';
import 'package:triplaner/domain/entities/login.dart';
import 'package:triplaner/domain/repositories/auth_repository.dart';
import 'package:triplaner/network/api_endpoint.dart';

import '../../network/network_repository.dart';

class RestAPIAuthRepository implements AuthRepository {
  NetworkRepository networkRepository;

  RestAPIAuthRepository({required this.networkRepository});

  @override
  Future<Login> createAccountWithEmailAndPassword(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    var response = await networkRepository.post(
      APIEndpoint.registerWithEmailAndPassword,
      {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "authType": "userAuth"
      },
      getFullResponse: true,
    );
    return LoginJson.fromJson(response).toDomain();
  }

  @override
  Future<Login> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    var response = await networkRepository.post(
      APIEndpoint.loginWithEmailAndPassword,
      {
        "email": email,
        "password": password,
      },
      getFullResponse: true,
    );

    return LoginJson.fromJson(response).toDomain();
  }

  final googleSignIn = GoogleSignIn(
    clientId: Platform.isIOS
        ? '727690186741-7vb9d1f90ehiiuat00ghefeersg2t03n.apps.googleusercontent.com'
        : null,
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.email'],
  );

  @override
  Future<Login> loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication authentication =
          await googleSignInAccount.authentication;
      debugPrint(
          "======> GOT GOOGLE INFORMATION : EMAIL: ${googleSignInAccount.email}");
      debugPrint(
          "======> GOT GOOGLE INFORMATION : ACCESS TOKEN: ${authentication.accessToken}");
      debugPrint(
          "======> GOT GOOGLE INFORMATION : ID TOKEN: ${authentication.idToken}");

      var response = await networkRepository.post(
        APIEndpoint.socialLogin,
        {
          "email": googleSignInAccount.email,
          "firstName": googleSignInAccount.displayName?.split(" ").first,
          "lastName": googleSignInAccount.displayName?.split(" ").last,
          "authType": "google",
        },
        getFullResponse: true,
      );
      return LoginJson.fromJson(response).toDomain();
    }
    throw "Something went wrong ${googleSignInAccount?.serverAuthCode}";
  }

  @override
  Future<Login> loginWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    debugPrint("@@@@@@@@@@ GOT APPLE  CREDENTIALS @@@@@@@@@@");
    final oAuthProvider = OAuthProvider('apple.com');

    final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    debugPrint(
        "@@@@@@@@@ FIREBASE AUTHENTICATING WITH CREDENTIALS @@@@@@@@@@@@");
    UserCredential userCredential =
        (await FirebaseAuth.instance.signInWithCredential(credential));

    debugPrint("@@@@@@@@@ GIVEN NAME : ${appleIdCredential.givenName}");
    debugPrint("@@@@@@@@@ FAMILY NAME : ${appleIdCredential.familyName}");

    final appleDisplayName =
        '${appleIdCredential.givenName ?? ""} ${appleIdCredential.familyName ?? ""}';
    String name = appleDisplayName.trim().isEmpty
        ? userCredential.user?.displayName ?? ""
        : appleDisplayName;
    String email = appleIdCredential.email ?? userCredential.user?.email ?? "";

    if (appleIdCredential.givenName != null) {
      userCredential.user?.updateDisplayName(name);
    }
    debugPrint("======> GOT APPLE INFORMATION : EMAIL: $email, NAME : $name");

    var response = await networkRepository.post(
      APIEndpoint.socialLogin,
      {
        "email": email,
        "firstName": name.split(" ").first,
        "lastName": name.split(" ").last,
        "authType": "apple",
      },
      getFullResponse: true,
    );
    return LoginJson.fromJson(response).toDomain();
  }

  @override
  Future<int> forgetPassword({required String email}) async {
    var response = await networkRepository.post(APIEndpoint.forgetPassword, {"email": email});
    return response['userId'];
  }

  @override
  Future<void> verifyOTP({required String otp, required String userId}) async {
    await networkRepository.put("${APIEndpoint.verifyOTP}/$userId", {"otp": int.parse(otp)});

  }

  @override
  Future<void> resetPassword(
      {required String newPassword,
      required String confirmPassword,
      required String userId}) async {
    await networkRepository.put("${APIEndpoint.resetPassword}/$userId",
        {"newPassword": newPassword, "confirmPassword": confirmPassword});
  }

  @override
  Future<void> logout() async {
    try {
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
