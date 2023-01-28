import 'package:blocapp/cubits/internet_cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCubitScreen extends StatelessWidget {
  const InternetCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Cubit'),
      ),
      body: Center(
        child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state == InternetState.connected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connected!'),
                ),
              );
            } else if (state == InternetState.lost) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Not Connected!'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state == InternetState.connected) {
              return const Text('Connected!');
            } else if (state == InternetState.lost) {
              return const Text('Not Connected!');
            } else {
              return const Text('Loading');
            }
          },
        ),
      ),
    );
  }
}
