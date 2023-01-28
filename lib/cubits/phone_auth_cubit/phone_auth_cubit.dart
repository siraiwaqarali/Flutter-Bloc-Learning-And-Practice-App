import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  PhoneAuthCubit() : super(PhoneAuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(PhoneAuthLoggedInState(firebaseUser: currentUser));
    } else {
      emit(PhoneAuthLoggedOutState());
    }
  }

  void sendOTP(String phoneNumber) async {
    emit(PhoneAuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(PhoneAuthCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(PhoneAuthErrorState(error.message ?? error.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(PhoneAuthLoadingState());
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );
    signInWithPhone(phoneAuthCredential);
  }

  void signInWithPhone(PhoneAuthCredential phoneAuthCredential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        emit(PhoneAuthLoggedInState(firebaseUser: userCredential.user!));
      }
    } on FirebaseAuthException catch (error) {
      emit(PhoneAuthErrorState(error.message ?? error.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(PhoneAuthLoggedOutState());
  }
}
