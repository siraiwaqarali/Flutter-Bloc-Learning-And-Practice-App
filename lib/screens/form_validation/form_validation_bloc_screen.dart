import 'package:blocapp/blocs/form_validation_bloc/form_validation_bloc.dart';
import 'package:blocapp/blocs/form_validation_bloc/form_validation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/form_validation_bloc/form_validation_state.dart';

class FormValidationBlocScreen extends StatefulWidget {
  const FormValidationBlocScreen({super.key});

  @override
  State<FormValidationBlocScreen> createState() =>
      _FormValidationBlocScreenState();
}

class _FormValidationBlocScreenState extends State<FormValidationBlocScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Validation using Bloc'),
      ),
      body: BlocBuilder<FormValidationBloc, FormValidationState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  state is FormValidationErrorState
                      ? Text(
                          state.error,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    onChanged: (value) {
                      BlocProvider.of<FormValidationBloc>(context).add(
                        FormValidationTextChangedEvent(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        ),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    onChanged: (value) {
                      BlocProvider.of<FormValidationBloc>(context).add(
                        FormValidationTextChangedEvent(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        ),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  state is FormValidationLoadingState
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (state is FormValidationValidState) {
                              BlocProvider.of<FormValidationBloc>(context).add(
                                FormValidationSubmitEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state is FormValidationValidState
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          child: const Text('Submit'),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
