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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.deepPurple
                ]
            )
        ),
        child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/assets/img/robot.png', width: 130),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hey!',
                              style: TextStyle(
                                fontFamily: 'happy',
                                fontSize: 45,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Don't have an account yet? Register now.",
                              style: TextStyle(
                                fontSize: 20,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Sign up to get started.',
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
                                          style: const TextStyle(color: Colors.white),
                                          controller: _nameTextController,
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.person, color: Colors.white),
                                              hintText: 'Enter Your Name',
                                              hintStyle: TextStyle(color: Colors.white)
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
                                          style: const TextStyle(color: Colors.white),
                                          controller: _userTextController,
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.person, color: Colors.white),
                                              hintText: 'Enter Your Username',
                                              hintStyle: TextStyle(color: Colors.white)
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
                                          style: const TextStyle(color: Colors.white),
                                          controller: _firstPasswordTextController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.key, color: Colors.white),
                                              hintText: 'Enter Your Password',
                                              hintStyle: TextStyle(color: Colors.white)
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
                                          style: const TextStyle(color: Colors.white),
                                          controller: _secondPasswordTextController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.key, color: Colors.white),
                                              hintText: 'Retype Your Password',
                                              hintStyle: TextStyle(color: Colors.white)
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
        ),
    );
  }
}
