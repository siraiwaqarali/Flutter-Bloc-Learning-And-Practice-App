import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_state.dart';
import 'package:blocapp/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneSigninScreen extends StatefulWidget {
  const PhoneSigninScreen({super.key});

  @override
  State<PhoneSigninScreen> createState() => _PhoneSigninScreenState();
}

class _PhoneSigninScreenState extends State<PhoneSigninScreen> {
  late final TextEditingController phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length != 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
                  listener: (context, state) {
                    if (state is PhoneAuthCodeSentState) {
                      Navigator.of(context).pushNamed(Constants.otpScreen);
                    }
                  },
                  builder: (context, state) {
                    if (state is PhoneAuthLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PhoneAuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String phoneNumber = '+92${phoneController.text}';
                          BlocProvider.of<PhoneAuthCubit>(context)
                              .sendOTP(phoneNumber);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width, 50),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Sign In'),
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
