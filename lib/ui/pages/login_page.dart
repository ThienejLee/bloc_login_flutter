import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Now")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: TextField(
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
                  child: Text("Login"),
                  onPressed: () async {},
                ),
                RaisedButton(
                  child: Text("Sign Up Now"),
                  onPressed: () async {},
                ),
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
