import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logregwithbloc/blocs/authBloc/auth_bloc.dart';
import 'package:logregwithbloc/blocs/authBloc/auth_event.dart';
import 'package:logregwithbloc/blocs/authBloc/auth_state.dart';

import 'ui/pages/home_page.dart';
import 'ui/pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => AuthBloc()..add(AppStartEvent()),
          child: App(),
        ));
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          return SplashScreen();
        } else if (state is AuthenticatedState) {
          return HomePage(state.user);
        } else if (state is UnAuthenticatedState) {
          return SignUpPage();
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Welcome",
        style: TextStyle(
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
