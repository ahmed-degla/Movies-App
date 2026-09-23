import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/models/user_model.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';

/// Handles Firebase Authentication and user profile synchronization.
@singleton
class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static const String _usersCollection = 'users';
  static const String _watchlistCollection = 'watchlist';
  static const String _historyCollection = 'history';

  // Web OAuth client ID.
  static const String _serverClientId =
      '680170815249-riuh0pqed8he27qm8iqqhlagbama0m8r.apps.googleusercontent.com';

  // ==================== Initialization ====================

  Future<void> initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize(serverClientId: _serverClientId);
    } on Object catch (_) {
      // Ignore initialization errors.
    }
  }

  // ==================== Firestore ====================

  CollectionReference<UserModel> get _usersRef => _firestore
      .collection(_usersCollection)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) =>
            UserModel.fromFirestore(snapshot.data() ?? {}),
        toFirestore: (user, _) => user.toFirestore(),
      );

  // ==================== Auth State ====================

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  bool get isAuthenticated => currentUser != null;

  // ==================== Email Authentication ====================

  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? avatar,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = userCredential.user;

    if (user == null) {
      return userCredential;
    }

    await user.updateDisplayName(name.trim());

    final userModel = UserModel(
      uid: user.uid,
      email: email.trim(),
      name: name.trim(),
      phone: phone?.trim(),
      avatar: avatar,
      image: avatar,
      createdAt: Timestamp.now(),
    );

    await _usersRef.doc(user.uid).set(userModel);

    return userCredential;
  }

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) => _firebaseAuth.signInWithEmailAndPassword(
    email: email.trim(),
    password: password,
  );

  // ==================== Google Authentication ====================

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.authenticate();

      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw FirebaseAuthException(
          code: 'google-sign-in-no-id-token',
          message: 'Google Sign-In did not return an ID token.',
        );
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user != null) {
        await _saveOrUpdateGoogleUser(user);
      }

      return userCredential;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }

      rethrow;
    }
  }

  // ==================== Password Reset ====================

  Future<void> sendPasswordResetEmail({required String email}) =>
      _firebaseAuth.sendPasswordResetEmail(email: email.trim());

  // ==================== Sign Out ====================

  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  // ==================== User Data ====================

  Future<UserModel?> getUserData(String uid) async {
    final snapshot = await _usersRef.doc(uid).get();

    return snapshot.data();
  }

  Future<UserModel?> getCurrentUserData() {
    final user = currentUser;

    if (user == null) {
      return Future.value();
    }

    return getUserData(user.uid);
  }

  CollectionReference<Map<String, dynamic>> _userMoviesRef(String collection) {
    final user = currentUser;
    if (user == null) {
      throw StateError('A signed-in user is required.');
    }

    return _firestore
        .collection(_usersCollection)
        .doc(user.uid)
        .collection(collection);
  }

  Map<String, dynamic> _movieData(MovieEntity movie) => {
    'movieId': movie.id,
    'rating': movie.rating,
    'genres': movie.genres,
    'backgroundImage': movie.backgroundImage,
    'backgroundImageOriginal': movie.backgroundImageOriginal,
    'smallCoverImage': movie.smallCoverImage,
    'mediumCoverImage': movie.mediumCoverImage,
    'largeCoverImage': movie.largeCoverImage,
    'updatedAt': FieldValue.serverTimestamp(),
  };

  MovieEntity _movieFromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? <String, dynamic>{};

    return MovieEntity(
      id: data['movieId'] as String? ?? snapshot.id,
      rating: data['rating'] as num? ?? 0,
      genres: List<String>.from(data['genres'] as List? ?? const []),
      backgroundImage: data['backgroundImage'] as String? ?? '',
      backgroundImageOriginal: data['backgroundImageOriginal'] as String? ?? '',
      smallCoverImage: data['smallCoverImage'] as String? ?? '',
      mediumCoverImage: data['mediumCoverImage'] as String? ?? '',
      largeCoverImage: data['largeCoverImage'] as String? ?? '',
    );
  }

  Future<void> addToWatchlist(MovieEntity movie) async {
    await _userMoviesRef(_watchlistCollection).doc(movie.id).set({
      ..._movieData(movie),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> removeFromWatchlist(String movieId) =>
      _userMoviesRef(_watchlistCollection).doc(movieId).delete();

  Stream<List<MovieEntity>> watchlistStream() =>
      _userMoviesRef(_watchlistCollection)
          .snapshots()
          .map((snapshot) => snapshot.docs.map(_movieFromSnapshot).toList());

  Future<void> addToHistory(MovieEntity movie) async {
    await _userMoviesRef(_historyCollection).doc(movie.id).set({
      ..._movieData(movie),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<List<MovieEntity>> historyStream() =>
      _userMoviesRef(_historyCollection)
          .snapshots()
          .map((snapshot) => snapshot.docs.map(_movieFromSnapshot).toList());

  Future<void> updateUserData(UserModel user) => _usersRef
      .doc(user.uid)
      .set(user.copyWith(updatedAt: Timestamp.now()), SetOptions(merge: true));

  Future<void> deleteAccount() async {
    final user = currentUser;

    if (user == null) {
      return;
    }

    await _usersRef.doc(user.uid).delete();
    await user.delete();
    await _googleSignIn.signOut();
  }

  // ==================== Private Helpers ====================

  Future<void> _saveOrUpdateGoogleUser(User user) async {
    final userRef = _usersRef.doc(user.uid);
    final userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      final userModel = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
        image: user.photoURL,
        avatar: user.photoURL,
        createdAt: Timestamp.now(),
      );

      await userRef.set(userModel);
      return;
    }

    final existingUser = userSnapshot.data();

    final userModel = UserModel(
      uid: user.uid,
      email: user.email ?? existingUser?.email ?? '',
      name: user.displayName ?? existingUser?.name ?? '',
      image: user.photoURL ?? existingUser?.image,
      avatar: user.photoURL ?? existingUser?.avatar,
      updatedAt: Timestamp.now(),
    );

    await userRef.set(userModel, SetOptions(merge: true));
  }
}
