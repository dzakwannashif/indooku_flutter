import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:indooku_flutter/helper/secureStorageHelper.dart';
import 'package:indooku_flutter/models/product.dart';
import 'package:indooku_flutter/models/user.dart';
import 'package:indooku_flutter/pages/detail.dart';
import 'package:indooku_flutter/services/productService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  bool isLoading = false;
  bool isError = false;
  String msg = '';

  User? user;

  @override
  void initState() {
    log('Init dipanggil');
    setState(() {
      isLoading = true;
    });
    ProductService.getProducts().then((value) {
      setState(() {
        products = value;
      });
      SecureStorageHelper.getUser().then((v) {
        setState(() {
          user = v;
        });
      });
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff9f9f9),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selamat Datang...👋',
                style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Color(0xff2A2526)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 200,
                child: Text(
                  '   ${user?.name.capitalize() ?? 'Anda Belum Login'}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DancingScript',
                    color: Color(0xffE7A600),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: GestureDetector(
                  onTap: () {},
                  child: ProfilePicture(
                    name: '${user?.name ?? ''}',
                    radius: 31,
                    fontsize: 21,
                  )),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50)),
              child: const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.grey,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : products.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 100,
                                color: Color(0xffd4d4d4),
                              ),
                              Text(
                                'Product masih kosong',
                                style: TextStyle(
                                  fontFamily: 'DancingScript',
                                  fontSize: 28,
                                  color: Color(
                                    0xffd4d4d4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 20,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            final product = products[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailProduct(
                                      product: product,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: product.image,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              width: 240,
                                              child: Text(
                                                product.name,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Color(0xff2A2526),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    product.price,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Color(0xffE7A600),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Stock: ',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    product.stock,
                                                    style: TextStyle(
                                                      color: Color(0xffE7A600),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
