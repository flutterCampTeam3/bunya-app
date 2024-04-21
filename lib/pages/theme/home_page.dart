import 'package:bunya_app/pages/theme/bloc/drak_mode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrakModeBloc, DrakModeState>(
      builder: (context, state) {
        final bloc = context.read<DrakModeBloc>();
        if (state is ShowThemeState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Theme'),
              actions: [
                //--------
                IconButton(
                    onPressed: () {
                      bloc.add(UpdateThemeEvent());
                      bloc.add(GetThemeEvent());


                    },
                    icon: state.currentTheme == 'Light'
                        ? const Icon(Icons.sunny, color: Colors.amber,)
                        : const Icon(Icons.dark_mode, color: Colors.grey))
                        
              ],
            ),
            body: Center(child: Text("${state.currentTheme} Theme")),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
