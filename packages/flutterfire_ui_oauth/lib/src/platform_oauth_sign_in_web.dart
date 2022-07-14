import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui/auth.dart';

import 'oauth_provider.dart';

/// {@macro ffui.oauth.platform_sign_in_mixin}
mixin PlatformSignInMixin {
  FirebaseAuth get auth;
  OAuthListener get authListener;
  dynamic get firebaseAuthProvider;

  /// {@macro ffui.oauth.platform_sign_in_mixin.platform_sign_in}
  void platformSignIn(TargetPlatform platform, AuthAction action) {
    Future<UserCredential> credentialFuture;

    if (action == AuthAction.link) {
      credentialFuture = auth.currentUser!.linkWithPopup(firebaseAuthProvider);
    } else {
      credentialFuture = auth.signInWithPopup(firebaseAuthProvider);
    }

    credentialFuture
        .then(authListener.onSignedIn)
        .catchError(authListener.onError);
  }
}