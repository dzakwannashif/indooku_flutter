import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/productService.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Product> products = [];
  bool isLoading = false;
  bool isError = false;
  String msg = '';

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
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detail Page',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Stack(
            children: [
              Container(
                child: ClipRRect(
                  child: Image(
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: Image.network(
                              'https://uwitan.id/wp-content/uploads/2020/12/DSC09507-scaled-728x410.jpg')
                          .image),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  Stack(children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kursi Foam Kayu',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Barang',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Stok: 150',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Rp. 100.000.000',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishin, t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ontent here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like), Lorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industrLorem Ipsum is simply dummy text of the printing and typesetting industr',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailProduct extends StatelessWidget {
  final Product product;
  const DetailProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detail Page',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Stack(
            children: [
              Container(
                child: ClipRRect(
                  child: Image(
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: Image.network(product.image).image),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  Stack(children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              product.category?.name ?? 'Tanpa kategori',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Stok: ${product.stock}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${product.price}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              product.description,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
