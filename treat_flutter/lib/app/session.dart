import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:treat_client/treat_client.dart';

import '../client.dart';

enum SessionStatus { loading, signedOut, needsRole, student, shop, error }

/// Who is signed in and in which role. The router redirects on this.
class AppSession extends ChangeNotifier {
  AppSession() {
    client.auth.authInfoListenable.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  SessionStatus status = SessionStatus.loading;

  /// Role picked on the welcome screen before signing up; onboarding opens
  /// straight on that form.
  UserRole? intendedRole;
  Me? me;
  Object? error;
  bool _loading = false;

  void _onAuthChanged() {
    if (client.auth.isAuthenticated) {
      refresh();
    } else {
      me = null;
      _set(SessionStatus.signedOut);
    }
  }

  /// Reloads the profile from the server.
  Future<void> refresh() async {
    if (_loading) return;
    _loading = true;
    if (me == null) _set(SessionStatus.loading);
    try {
      apply(await client.profile.getMe());
    } catch (e) {
      error = e;
      _set(SessionStatus.error);
    } finally {
      _loading = false;
    }
  }

  void apply(Me value) {
    me = value;
    error = null;
    _set(switch (value.role) {
      null => SessionStatus.needsRole,
      UserRole.student => SessionStatus.student,
      UserRole.shop => SessionStatus.shop,
    });
  }

  Future<void> signOut() => client.auth.signOutDevice();

  void _set(SessionStatus s) {
    status = s;
    notifyListeners();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_onAuthChanged);
    super.dispose();
  }
}

/// App-wide instance; the router and screens read it.
final appSession = AppSession();
