import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:indooku_flutter/helper/secureStorageHelper.dart';
import 'package:indooku_flutter/models/user.dart';
import 'package:indooku_flutter/pages/login.dart';
import 'package:indooku_flutter/services/authServices.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoading = true;
  bool isError = false;
  String msg = '';

  User? user;

  @override
  void initState() {
    SecureStorageHelper.getUser().then((value) {
      isLoading = false;
      user = value!;
      setState(() {});
    }).catchError((e) {
      isError = true;
      msg = e.toString();
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff9f9f9),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit_rounded,
              color: Color(0xffE7A600),
            ),
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : isError
              ? Center(
                  child: Text('${msg} error'),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ProfilePicture(
                                    name: '${user?.name}',
                                    count: 3,
                                    radius: 100,
                                    fontsize: 32,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            '${user?.name ?? 'John Doe'}',
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            '${user?.email ?? ''}',
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            setState(
                              () {
                                isLoading = true;
                              },
                            );
                            final isSuccessLogout = await AuthService.logout();
                            if (isSuccessLogout) {
                              await SecureStorageHelper.deleteDataLokalSemua();
                              setState(() {
                                isLoading = false;
                              });
                              if (!mounted) return;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginPage(),
                                  ),
                                  (_) => false);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              if (!mounted) return;
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                    content: Text('Logout Gagal')));
                            }
                          },
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2A2526),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
