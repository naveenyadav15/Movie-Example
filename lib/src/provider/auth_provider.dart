import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_provider/src/utils/preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  //FirebaseAuth instance
  AuthProvider(this.firebaseAuth);
  // Constuctor to initalize the FirebaseAuth instance
  String verificationId;

  // Using Stream to listen to Authentication State
  Stream<User> get authState => firebaseAuth.idTokenChanges();


  Future<void> verifyPhone(String countryCode, String mobile) async {
    var mobileToSend = mobile;
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            // Starts the phone number verification process for the given phone number.
            // Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exception) {
            throw exception;
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final UserCredential user =
          await firebaseAuth.signInWithCredential(credential);
      final User currentUser = firebaseAuth.currentUser;
      print(user);

      if (currentUser.uid != "") {
        print(currentUser.uid);
        await Preferences.saveUserId(currentUser.uid);

        await Preferences.savePhoneNumber(currentUser.phoneNumber);
      }
    } catch (e) {
      throw e;
    }
  }

  showError(error) {
    throw error.toString();
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
