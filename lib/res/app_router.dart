import 'package:blocapp/api_lib/logic/cubits/post_cubit/post_cubit.dart';
import 'package:blocapp/api_lib/presentation/screens/api_home_screen.dart';
import 'package:blocapp/blocs/form_validation_bloc/form_validation_bloc.dart';
import 'package:blocapp/res/constants.dart';
import 'package:blocapp/screens/form_validation/form_validation_bloc_screen.dart';
import 'package:blocapp/screens/home/home_screen.dart';
import 'package:blocapp/screens/internet/internet_bloc_screen.dart';
import 'package:blocapp/screens/internet/internet_cubit_screen.dart';
import 'package:blocapp/screens/phone_auth/otp_screen.dart';
import 'package:blocapp/screens/phone_auth/phone_auth_home_screen.dart';
import 'package:blocapp/screens/phone_auth/phone_signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Constants.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Constants.internetBlocScreen:
        return MaterialPageRoute(builder: (_) => const InternetBlocScreen());
      case Constants.internetCubitScreen:
        return MaterialPageRoute(builder: (_) => const InternetCubitScreen());
      case Constants.formValidationBlocScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => FormValidationBloc(),
                  child: const FormValidationBlocScreen(),
                ));
      case Constants.phoneSigninScreen:
        return MaterialPageRoute(builder: (_) => const PhoneSigninScreen());
      case Constants.otpScreen:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case Constants.phoneAuthHomeScreen:
        return MaterialPageRoute(builder: (_) => const PhoneAuthHomeScreen());
      case Constants.apiHomeScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => PostCubit(),
                  child: const ApiHomeScreen(),
                ));
      default:
        return null;
    }
  }
}
