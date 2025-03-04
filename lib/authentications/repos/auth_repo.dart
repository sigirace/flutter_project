import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/authentications/models/user.dart';
import 'package:riverpod/riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebasAuth = FirebaseAuth.instance;

  bool get isLoggedIn => _firebasAuth.currentUser != null;
  User? get user => _firebasAuth.currentUser;

  Future<UserCredential> signUp(UserData userData) async {
    return await _firebasAuth.createUserWithEmailAndPassword(
      email: userData.email!,
      password: userData.password!,
    );
  }

  Future<void> signIn(String email, String password) async {
    await _firebasAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebasAuth.signOut();
  }

  Stream<User?> authStateChanges() => _firebasAuth.authStateChanges();
}

final authRepo = Provider((ref) => AuthenticationRepository());

final authState = StreamProvider((ref) {
  final repo = ref.watch(authRepo);
  return repo.authStateChanges();
});
