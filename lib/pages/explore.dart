import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:indooku_flutter/models/product.dart';
import 'package:indooku_flutter/pages/category.dart';
import 'package:indooku_flutter/services/category_service.dart';

import '../helper/secureStorageHelper.dart';
import '../models/category.dart';
import '../models/user.dart';

class Explorepage extends StatefulWidget {
  const Explorepage({super.key});

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage> {
  final List<Category> categories = [];
  bool isLoading = true;
  bool isError = false;
  String msg = '';
  User? user;

  @override
  void initState() {
    CategoryService.getcategorys().then((value) {
      setState(() {
        categories.addAll(value);
      });

      SecureStorageHelper.getUser().then((v) {
        setState(() {
          user = v;
          isLoading = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xfff9f9f9),
      //   elevation: 0,
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Align(
      //         alignment: Alignment.center,
      //         child: Text(
      //           'Explore By...',
      //           style: TextStyle(
      //               fontSize: 12,
      //               fontStyle: FontStyle.italic,
      //               color: Color(0xff2A2526)),
      //         ),
      //       ),
      //       Align(
      //         alignment: Alignment.center,
      //         child: SizedBox(
      //           child: isLoading
      //               ? Text('Sedang memuat..')
      //               : Text(
      //                   'Categories',
      //                   maxLines: 1,
      //                   style: TextStyle(
      //                     fontSize: 24,
      //                     fontWeight: FontWeight.w600,
      //                     fontFamily: 'Quicksand',
      //                     color: Color(0xffE7A600),
      //                   ),
      //                 ),
      //         ),
      //       ),
      //     ],
      //   ),
      // actions: [
      //   isLoading
      //       ? Text('Sedang memuat')
      //       : Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: SizedBox(
      //             width: 40,
      //             height: 40,
      //             child: GestureDetector(
      //               onTap: () {},
      //               child: ProfilePicture(
      //                 name: '${user?.name}',
      //                 radius: 31,
      //                 fontsize: 21,
      //               ),
      //             ),
      //           ),
      //         ),
      // ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "explore by your...",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w800,
                    color: Color(0xffE7A600)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            isLoading
                ? Expanded(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CategoryPage(category: category);
                                    },
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.fitWidth,
                                          image: Image.network(category.image)
                                              .image),
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.1),
                                          Colors.black.withOpacity(0.2),
                                          Colors.black.withOpacity(0.5),
                                          Colors.black.withOpacity(0.7),
                                          Colors.black.withOpacity(0.9),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.name.capitalize(),
                                          style: TextStyle(
                                              fontFamily: 'DancingScript',
                                              fontSize: 28,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          'Stock ${category.productCount}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 30,
                        ); // Menggunakan Divider sebagai pemisah antara item
                      },
                      itemCount: categories.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
