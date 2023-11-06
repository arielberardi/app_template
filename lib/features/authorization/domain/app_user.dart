/// Type defining a user ID from Firebase.
typedef UserID = String;

class AppUser {
  const AppUser({required this.uid, required this.email});

  final UserID uid;
  final String email;

  @override
  String toString() => 'AppUser(uid: $uid, email: $email)';
}
