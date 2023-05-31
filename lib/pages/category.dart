import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../helper/secureStorageHelper.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../services/productService.dart';
import 'detail.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<Product> products = [];
  bool isLoading = true;
  bool isError = false;
  String msg = '';

  User? user;

  @override
  void initState() {
    log('Init dipanggil');
    ProductService.getProducts(categoryId: widget.category.id.toString())
        .then((value) {
      products.addAll(value);
      isLoading = false;
      setState(() {});
    }).catchError((e) {
      isError = true;
      msg = e.toString();
      isLoading = false;
      setState(() {});
    });
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
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selamat Datang...',
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
                child: isLoading
                    ? Text('sedang memuat..')
                    : Text(
                        '   ${user?.name}',
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
                  child: isLoading
                      ? Text('sedang memuat..')
                      : ProfilePicture(
                          name: '${user?.name.capitalize()}',
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
            SizedBox(
              height: 150,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              image:
                                  Image.network(widget.category.image).image),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.category.name,
                              style: TextStyle(
                                  fontFamily: 'DancingScript',
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Stock ${widget.category.productCount}',
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
            ),
            SizedBox(
              height: 20,
            ),
            isLoading
                ? Text('sedang memuat..')
                : products.isEmpty
                    ? Center(
                        child: Text('Produk kosong'),
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
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: GestureDetector(
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
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: product.image),
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
