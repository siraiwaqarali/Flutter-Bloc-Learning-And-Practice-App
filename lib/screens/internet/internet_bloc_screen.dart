import 'package:blocapp/blocs/internet_bloc/internet_bloc.dart';
import 'package:blocapp/blocs/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBlocScreen extends StatelessWidget {
  const InternetBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Bloc'),
      ),
      body: Center(
        // If you want to do use both UI or anything like navigation,
        // showing snackbar etc ---> use BlocListener
        child: BlocConsumer<InternetBloc, InternetState>(
          listener: (context, state) {
            if (state is InternetConnectedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connected!'),
                ),
              );
            } else if (state is InternetLostState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Not Connected!'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is InternetConnectedState) {
              return const Text('Connected!');
            } else if (state is InternetLostState) {
              return const Text('Not Connected!');
            } else {
              return const Text('Loading');
            }
          },
        ),
        // If you want to do anything like navigation, showing snackbar etc ---> use BlocListener
        // child: BlocListener<InternetBloc, InternetState>(
        //   listener: (context, state) {
        //     if (state is InternetConnectedState) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //           content: Text('Connected!'),
        //         ),
        //       );
        //     } else if (state is InternetLostState) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //           content: Text('Not Connected!'),
        //         ),
        //       );
        //     }
        //   },
        //   child: const Text('Internet Bloc'),
        // ),
        // If you want to show only UI ---> use BlocBuilder
        // child: BlocBuilder<InternetBloc, InternetState>(
        //   builder: (context, state) {
        //     if (state is InternetConnectedState) {
        //       return const Text('Connected!');
        //     } else if (state is InternetLostState) {
        //       return const Text('Not Connected!');
        //     } else {
        //       return const Text('Loading');
        //     }
        //   },
        // ),
      ),
    );
  }
}
