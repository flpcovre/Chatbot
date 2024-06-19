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
      body: Center(
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
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Welcome to your personal ChatBot.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Sign in to get started.',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
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
                              controller: _userTextController,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Your Username'
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
                              controller: _passwordTextController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.key),
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Your Password'
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
                              child: Text('Sign Up Now'),
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
        )
      ),
    );
  }
}

