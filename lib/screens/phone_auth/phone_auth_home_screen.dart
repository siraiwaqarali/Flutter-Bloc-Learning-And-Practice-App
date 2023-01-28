import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_state.dart';
import 'package:blocapp/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneAuthHomeScreen extends StatelessWidget {
  const PhoneAuthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Auth Home'),
      ),
      body: Center(
        child: BlocListener<PhoneAuthCubit, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthLoggedOutState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Constants.homeScreen,
                (route) => false,
              );
            }
          },
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<PhoneAuthCubit>(context).logOut();
            },
            child: const Text('Log Out'),
          ),
        ),
      ),
    );
  }
}
