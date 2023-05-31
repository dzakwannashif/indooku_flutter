import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:indooku_flutter/API/api.dart';
import 'package:indooku_flutter/pages/home.dart';
import 'package:indooku_flutter/pages/register.dart';
import 'package:indooku_flutter/services/authServices.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import 'navbot.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final emailC = TextEditingController();

  final passC = TextEditingController();
  bool isLoading = false;

  bool isError = false;
  String msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Have you make an account?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                if (isError)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '$msg',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 50),
                                TextFormField(
                                  controller: emailC,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'email tidak boleh kosong';
                                    } else if (!isEmail(value)) {
                                      return 'Email tidak valid';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      )),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                TextFormField(
                                  controller: passC,
                                  obscureText: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff2A2526),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      onPressed: () async {
                                        setState(() {
                                          isError = false;
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          try {
                                            final user =
                                                await AuthService.login(
                                                    email: emailC.text,
                                                    password: passC.text);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            if (!mounted) return;
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            NavigationBarPage()),
                                                    (route) => false);
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'Haven\'t yet an account? just try to'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return RegisterPage();
                                            },
                                          ),
                                        );
                                      },
                                      child: Text('Register'),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return NavigationBarPage();
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xff2A2526),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
