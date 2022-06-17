import 'package:flutter/material.dart';
import 'package:project_app/authentication/sign_in.dart';
import 'package:project_app/screens/first_screen.dart';
import 'package:project_app/screens/home_page.dart';

import 'second_screen.dart';
import '../Authentication/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController _emailController = TextEditingController(text: "");
TextEditingController _passController = TextEditingController(text: "");

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 70),
                        const FlutterLogo(size: 150),
                        const SizedBox(height: 20),
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: const Text('Email',
                                      style: TextStyle(fontSize: 13))),
                              const SizedBox(height: 2),
                              Center(
                                child: Container(
                                  width: 320,
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: const Text('Password',
                                      style: TextStyle(fontSize: 13))),
                              const SizedBox(height: 2),
                              Center(
                                child: Container(
                                  width: 320,
                                  child: TextFormField(
                                    controller: _passController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _Loginbutton(),
                              const SizedBox(height: 10),
                              _Registerbutton(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const <Widget>[
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'OR',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Divider(thickness: 1, color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _signInButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: const BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Registerbutton extends StatelessWidget {
  const _Registerbutton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        child: RaisedButton(
          onPressed: () async {
            AuthenticationHelper()
                .signUp(_emailController.text, _passController.text)
                .then((result) {
              if (result == null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              email: _emailController.text,
                            )));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    result,
                    style: const TextStyle(fontSize: 16),
                  ),
                ));
              }
            });
          },
          child: const Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: const Color(0xFF4f4f4f),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class _Loginbutton extends StatelessWidget {
  const _Loginbutton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        child: RaisedButton(
          onPressed: () async {
            await AuthenticationHelper()
                .signIn(_emailController.text, _passController.text)
                .then((result) {
              if (result == null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              email: _emailController.text,
                            )));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    result,
                    style: TextStyle(fontSize: 16),
                  ),
                ));
              }
            });
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: const Color(0xFF4f4f4f),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
