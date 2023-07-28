import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtest/module/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newtest/module/login/view/login_view.dart';
import 'package:newtest/module/login/view/tes.dart';
import '../../../routes/app_pages.dart';
import '../../../local_storage/local_storage_helper.dart';
import '../../../widget/toast.dart';

class SignUpController extends GetxController with StateMixin {
  //TextEditing
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerUsername = TextEditingController();

  //Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  RxString tokenNew = ''.obs;

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        Toast.showErrorToastWithoutContext('Sukses Login');
        Get.to(Test());
      } else {
        Toast.showErrorToastWithoutContext('Gagal Login');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signupAuth(
      context, String email, String password, String username) async {
    change(null, status: RxStatus.loading());
    if (username.isEmpty) {
      Toast.showErrorToastWithoutContext('Username Wajib diisi');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((UserCredential userCredential) {
          return userCredential.user!.getIdToken().then((String token) {
            return userCredential;
          });
        });

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'username': username,
          'email': email,
        });

        Get.back();
        clearController();
        Toast.showSuccessToastWithoutContext('Berhasil Daftar');
      } on FirebaseException catch (e) {
        if (e.code == "weak-password") {
          Toast.showErrorToastWithoutContext('Password Lemah');
        } else if (e.code == 'email-already-in-use') {
          Toast.showErrorToastWithoutContext('email sudah digunakan');
          print('email sudah digunakan');
        } else if (e.code == 'Password should be at least 6 characters') {
          Toast.showErrorToastWithoutContext(
              'Password setidaknya lebih dari 6 charackter');
        } else {
          Toast.showErrorToastWithoutContext('Format Salah');
          print('something wrong');
        }
      }
    }
    change(null, status: RxStatus.success());
  }

  void clearController() {
    controllerUsername.clear();
    controllerEmail.clear();
    controllerPassword.clear();
  }

  @override
  void onClose() {
    Get.delete<SignUpController>();
    super.onClose();
  }
}
