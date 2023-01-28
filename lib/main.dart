import 'package:blocapp/blocs/internet_bloc/internet_bloc.dart';
import 'package:blocapp/cubits/internet_cubit/internet_cubit.dart';
import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:blocapp/cubits/phone_auth_cubit/phone_auth_state.dart';
import 'package:blocapp/firebase_options.dart';
import 'package:blocapp/res/app_router.dart';
import 'package:blocapp/res/constants.dart';
import 'package:blocapp/screens/home/home_screen.dart';
import 'package:blocapp/screens/phone_auth/phone_auth_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
        BlocProvider(
          create: (context) => InternetCubit(),
        ),
        BlocProvider(
          create: (context) => PhoneAuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
          buildWhen: (oldState, newState) {
            return oldState is PhoneAuthInitialState;
          },
          builder: (context, state) {
            if (state is PhoneAuthLoggedInState) {
              return const PhoneAuthHomeScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
