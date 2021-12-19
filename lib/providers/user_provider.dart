import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  GoogleSignInAccount? _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
    ],
  );

  GoogleSignInAccount? getUser() => _currentUser;

  void setUser(GoogleSignInAccount account) {
    _currentUser = account;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _googleSignIn.disconnect();
    notifyListeners();
  }

  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();
}
