import 'dart:math';

import 'package:flutter/material.dart';
import 'package:indooku_flutter/API/api.dart';
import 'package:indooku_flutter/pages/home.dart';
import 'package:indooku_flutter/pages/login.dart';
import 'package:indooku_flutter/services/authServices.dart';
import 'package:validators/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final nameC = TextEditingController();

  final emailC = TextEditingController();

  final passC = TextEditingController();

  bool isLoading = false;

  bool isError = false;
  String msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Do you want to make an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        if (isError)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$msg',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: nameC,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'nama tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: emailC,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email tidak boleh kosong';
                            } else if (!isEmail(value)) {
                              return 'email tidak valid';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: passC,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password tidak boleh kosong';
                            } else if (value.length < 8) {
                              return 'password minimal 8 karakter';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: TextEditingController(),
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password tidak boleh kosong';
                            } else if (value.length < 8) {
                              return 'password minimal 8 karakter';
                            } else if (value != passC.value.text) {
                              return 'password tidak sama';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginPage();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff2A2526),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isError = false;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        final user = await AuthService.register(
                                          name: nameC.text,
                                          email: emailC.text,
                                          password: passC.text,
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                        if (!mounted) return;
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (_) => HomePage(),
                                          ),
                                          (route) => false,
                                        );
                                      } on CustomException catch (e) {
                                        setState(() {
                                          msg = e.message;
                                          isError = true;
                                          isLoading = false;
                                        });
                                      } catch (e) {
                                        setState(() {
                                          msg = e.toString();
                                          isError = true;
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    backgroundColor: const Color(0xff2A2526),
                                    minimumSize: const Size(
                                      200,
                                      50,
                                    ),
                                  ),
                                  child: const Text('Confirm'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
