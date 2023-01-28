import 'package:blocapp/res/constants.dart';
import 'package:blocapp/screens/home/components/home_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Learning/Practice'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              HomeButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  Constants.internetBlocScreen,
                ),
                text: 'Internet Bloc',
              ),
              const SizedBox(height: 10),
              HomeButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  Constants.internetCubitScreen,
                ),
                text: 'Internet Cubit',
              ),
              const SizedBox(height: 10),
              HomeButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  Constants.formValidationBlocScreen,
                ),
                text: 'Form Validation using Bloc',
              ),
              const SizedBox(height: 10),
              HomeButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  Constants.phoneSigninScreen,
                ),
                text: 'Phone Authentication',
              ),
              const SizedBox(height: 10),
              HomeButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  Constants.apiHomeScreen,
                ),
                text: 'API Handling (Cubit + Dio with Interceptor)',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
