import 'package:flutter/material.dart';
import 'package:chatbot/controller/LoginController.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userTextController = TextEditingController();
  final TextEditingController _firstPasswordTextController = TextEditingController();
  final TextEditingController _secondPasswordTextController = TextEditingController();
  final LoginController _loginController = LoginController();
  bool _registerError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
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
                        'Hey!',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Don't have an account yet? Register now.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Sign up to get started.',
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
                          if (_registerError)
                            const Text(
                              'Fill in the data correctly',
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
                                    setState(() {
                                      _registerError = true;
                                    });
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
                                controller: _firstPasswordTextController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.key),
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Your Password'
                                ),
                                validator: (password1) {
                                  if (password1 == null || password1.isEmpty) {
                                    setState(() {
                                      _registerError = true;
                                    });
                                    return null;
                                  }
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
                                controller: _secondPasswordTextController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.key),
                                    border: OutlineInputBorder(),
                                    labelText: 'Retype Your Password'
                                ),
                                validator: (password2) {
                                  if (password2 == null || password2.isEmpty) {
                                    setState(() {
                                      _registerError = true;
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
                                    setState(() {
                                      _registerError = false;
                                    });
                                  }
                                },
                                child: const Text('Sign Up'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
