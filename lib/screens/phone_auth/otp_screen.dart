import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_state.dart';
import 'package:blocapp/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final TextEditingController otpController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Phone Auth using Cubits'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '6-Digit OTP',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the OTP';
                      } else if (value.length != 6) {
                        return 'Please enter 6 digit OTP';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
                  listener: (context, state) {
                    if (state is PhoneAuthLoggedInState) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Constants.phoneAuthHomeScreen,
                        (route) => false,
                      );
                    } else if (state is PhoneAuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PhoneAuthLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<PhoneAuthCubit>(context)
                              .verifyOTP(otpController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width, 50),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Verify'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
