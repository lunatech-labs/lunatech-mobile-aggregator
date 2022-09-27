import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static final GoogleService _googleService = GoogleService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"], hostedDomain: "lunatech.nl");

  GoogleService._internal();

  factory GoogleService() {
    return _googleService;
  }

  Future<void> signIn() => _googleSignIn.signIn();
  Future<void> signOut() => _googleSignIn.signOut();
  GoogleSignInAccount getAccount() => _googleSignIn.currentUser!;
  Future<GoogleSignInAuthentication> getAuthentication() async => getAccount().authentication;
  Future<String> getAccessToken() async => getAuthentication().then((authentication) => authentication.accessToken!);
}
