import 'package:newtest/module/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newtest/module/login/view/tes.dart';
import '../../../local_storage/local_storage_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/toast.dart';

class LoginController extends GetxController {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  RxString tokenNew = ''.obs;

  Future googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        Toast.showErrorToastWithoutContext('Sukses Login');
        Get.to(Test());
      } else {
        Toast.showErrorToastWithoutContext('Gagal Login');
      }
      print('sukses');
    } catch (e) {
      print(e.toString());
    }
  }

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

  Future<void> signupAuth(context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) {
        return userCredential.user!.getIdToken().then((String token) {
          print(token);
          return userCredential;
        });
      });
      Get.to(EventListView());
    } on FirebaseException catch (e) {
      if (e.code == "weak-password") {
        print('password waek');
      } else if (e.code == 'email-already-in-use') {
        print('email sudah digunakan');
      } else {
        print('something wrong');
      }
    }
  }

  Future<void> loginAuth(context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) {
        return userCredential.user!.getIdToken().then((String token) {
          tokenNew.value = token;
          return userCredential;
        });
      });

      Get.offAllNamed(Routes.HOME);
      Toast.showSuccessToastWithoutContext('Berhasil Login');
      await SharedPreferenceHelper.setUserUid(userCredential.user!.uid);
      String? data = await SharedPreferenceHelper.getUserUid();
      print(data);
      clearController();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('email tidak ditemukan');
        Toast.showErrorToastWithoutContext(e.code);
      } else if (e.code == 'wrong-password') {
        print('password salah');

        Toast.showErrorToastWithoutContext(e.code);
      } else {
        Toast.showErrorToastWithoutContext(e.code);

        print(e.code);
      }
    }
  }

  void clearController() {
    controllerEmail.clear();
    controllerPassword.clear();
  }

  RxInt value = 0.obs;

  RxString dataShared = ''.obs;

  void getDataFromSharedPreference() async {
    int? data = await SharedPreferenceHelper.getDataPrelogin();
    value.value = data ?? 0;
    print(value);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
