import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logregwithbloc/blocs/regBloc/user_reg_bloc.dart';
import 'package:logregwithbloc/blocs/regBloc/user_reg_event.dart';
import 'package:logregwithbloc/blocs/regBloc/user_reg_state.dart';
import 'package:logregwithbloc/ui/pages/home_page.dart';
import 'package:logregwithbloc/ui/pages/login_page.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UserRegBloc userRegBloc;

  @override
  Widget build(BuildContext context) {
    userRegBloc = BlocProvider.of<UserRegBloc>(context);

    return BlocProvider(
      create: (context) => UserRegBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text("Sign Up")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocListener<UserRegBloc, UserRegState>(
                listener: (context, state) {
                  if (state is UserRegSuccessful) {
                    navigateToHomePage(context, state.user);
                  }
                },
                child: BlocBuilder<UserRegBloc, UserRegState>(
                    builder: (context, state) {
                  if (state is UserRegInitial) {
                    return buildInitialUi();
                  } else if (state is UserLoadingState) {
                    return buildLoadingUi();
                  } else if (state is UserRegSuccessful) {
                    return Container();
                  } else if (state is UserRegFailure) {
                    return buildFailureUi(state.message);
                  }
                }),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "E-mail",
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: 'Password'),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Sign Up"),
                    onPressed: () async {
                      userRegBloc.add(SignUpButtonPressedEvent(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                  ),
                  RaisedButton(
                    child: Text("Login No"),
                    onPressed: () async {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInitialUi() {
    return Text("Waiting for user registration");
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Text(
      message,
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }

  void navigateToHomePage(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePage(user);
    }));
  }

  void navigateToLoginPage(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }
}
