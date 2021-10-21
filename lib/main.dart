import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_blocin/blocs/todo_bloc/todo_bloc.dart';
import 'blocs/theme_bloc/theme_bloc.dart';
import 'package:time_blocin/navigation/app_navigator.dart';

import 'cubits/nav_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// Multi Bloc Providers
  /// For Navigation and Logic
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ThemeBloc()),
        BlocProvider(create: (BuildContext context) => NavCubit()),
        BlocProvider(
            create: (BuildContext context) =>
            TodoBloc()..add(GetTodoEvent())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state)
        {
          return MaterialApp(
            home: AppNavigator(),
            theme: state.themeData,
          );
        },
      ),
    );
  }
}
