import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this.auth);

  final FirebaseAuth auth;

  Stream<User?> authStateChanges() => auth.authStateChanges();

  User? get currentUser => auth.currentUser;

  bool isSignedIn() => currentUser != null;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  // We use UnimplementedError as the FirebaseAuth may not be available
  // at the startup of the app so we rely on Dependency Override from riverpod
  // to set the value for this provider.
  // Which is going to be AuthRepository(FirebaseAuth.instance)
  throw UnimplementedError();
}

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}
