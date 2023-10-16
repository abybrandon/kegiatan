import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/toast.dart';

class ProfileUserController extends GetxController {

  Future<void> sendOTP() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: "+62895392436676",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print('Failed to send OTP: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // OTP sent successfully, handle verification here
        Toast.showSuccessToastWithoutContext('success send otp');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
