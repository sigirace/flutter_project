import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebasAuth = FirebaseAuth.instance;

  bool get isLoggedIn => _firebasAuth.currentUser != null;
  User? get user => _firebasAuth.currentUser;
}

final authRepo = Provider((ref) => AuthenticationRepository().user);
