import 'package:flutter/material.dart';
import 'package:chatbot/controller/LoginController.dart';
import 'package:chatbot/factories/DialogFactory.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final TextEditingController _userTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
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
                                      controller: _nameTextController,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Your Name'
                                      ),
                                    ),
                                  ),
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
                                          bool isCreated = await _loginController.signUp(_nameTextController.text, _userTextController.text, _firstPasswordTextController.text, _secondPasswordTextController.text);
                                          if (isCreated) {
                                            setState(() {
                                              _registerError = false;
                                            });
                                              DialogFactory.show(
                                                  context,
                                                  title: 'Sucesso',
                                                  content: 'Usuário Criado com Sucesso!',
                                                  onOkPressed: () {
                                                    Navigator.of(context).pushReplacementNamed('/login');
                                                  }
                                              );
                                          } else {
                                            setState(() {
                                              _registerError = true;
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
              ],
            ),
          ),
    );
  }
}
