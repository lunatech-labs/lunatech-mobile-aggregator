import 'dart:io';

import 'package:flutter_apps/util/secureconfigs.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static final GoogleService _googleService = GoogleService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS ? iosClientId : null,
      scopes: ["email"]
  );

  GoogleService._internal();

  factory GoogleService() {
    return _googleService;
  }

  Future<bool> signIn() => _googleSignIn.signIn().then((_) => _googleSignIn.isSignedIn());
  Future<void> signOut() => _googleSignIn.signOut();
  GoogleSignInAccount getAccount() => _googleSignIn.currentUser!;
  Future<GoogleSignInAuthentication> getAuthentication() async => getAccount().authentication;
  Future<String> getAccessToken() async => getAuthentication().then((authentication) => authentication.accessToken!);

  bool isUser(String email) => email == getAccount().email;
  Future<bool> isSignedIn() async => _googleSignIn.isSignedIn();
}
