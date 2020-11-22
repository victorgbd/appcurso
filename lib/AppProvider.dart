import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formusers/dependencies_injection.dart';
import 'package:formusers/pages/home_page.dart';

import 'cubit/UserAdmin_cubit.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdminUserCubit>(),
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark().copyWith(accentColor: Colors.pink),
        theme: ThemeData.light(),
        home: HomePage(),
      ),
    );
  }
}
