/* import '../../features/user/domain/entities/user.dart';

class FirebaseSingleton {
  FirebaseSingleton._private();

  static final _instance = FirebaseSingleton._private();

  factory FirebaseSingleton() => _instance;

  final _auth = FirebaseAuth.instance;

  bool get isLoggedIn => _auth.currentUser != null;

  Future<User> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user == null) {
        throw 'Login failed';
      }
      return user.user!;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'Email is invalid';
        case 'user-not-found':
          throw 'User is not found please sign up';
        case 'wrong-password':
          throw 'Email or password is incorrect';
        default:
          throw 'Unable to sign in please try again later';
      }
    } catch (_) {
      throw 'Unable to sign in please try again later';
    }
  }

  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final createdUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (createdUser.user == null) {
        throw 'Login failed';
      }
      return createdUser.user!;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
      throw e.message ?? 'Internet connection error';
    } catch (_) {
      rethrow;
    }
  }
}
 */