import 'package:chatbot/view/Chat.dart';
import 'package:chatbot/view/UserRegister.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/controller/LoginController.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final LoginController _loginController = LoginController();
  bool _loginError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.purple
            ]
          )
        ),
        child: Center(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hello!',
                            style: TextStyle(
                              fontFamily: 'happy',
                              fontSize: 60,
                              color: Colors.white
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Welcome to your personal ChatBot.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Sign in to get started.',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (_loginError)
                              const Text(
                                'Incorrect username or password.',
                                style: TextStyle(color: Colors.red),
                              ),
                            SizedBox(
                              width: 340,
                              height: 55,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: _userTextController,
                                  decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.white),
                                      prefixIcon: Icon(Icons.person, color: Colors.white),
                                      hintText: 'Enter your username',
                                      hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  validator: (user) {
                                    if (user == null || user.isEmpty) {
                                      _loginError = true;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 340,
                              height: 55,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: _passwordTextController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelStyle: TextStyle(color: Colors.white),
                                      prefixIcon: Icon(Icons.key, color: Colors.white),
                                      hintText: 'Enter your password',
                                      hintStyle: TextStyle(color: Colors.white)
                                  ),
                                  validator: (password) {
                                    if (password == null || password.isEmpty) {
                                      setState(() {
                                        _loginError = true;
                                      });
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 340,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    )
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                        var isAuth = await _loginController.signIn(_userTextController.text, _passwordTextController.text);
                                        if (isAuth) {
                                          setState(() {
                                            _loginError = false;
                                          });
                                          Navigator.of(context).pushReplacementNamed('/chat');
                                        } else {
                                          setState(() {
                                            _loginError = true;
                                          });
                                          return;
                                        }
                                    }
                                  },
                                  child: const Text('Sign In'),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _loginError = false;
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserRegister()));
                                  },
                                  child: Text(
                                    'Sign Up Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      )
    );
  }
}

