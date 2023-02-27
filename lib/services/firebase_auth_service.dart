import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/kandidates_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService {
  FireBaseAuthService() {
    getData();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<void> registation({
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> ressetPassword({
    required String email,
  }) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<ListCandidates> getData() async {
    final response = await _store.collection('1').doc('candidates').get();

    final result = ListCandidates.fromJson(response.data()!);

    return result;
  }

  Future<void> sendData({required ListCandidates data}) async {
    await _store.collection('1').doc('candidates').update(
          data.toJson(),
        );
  }
}
