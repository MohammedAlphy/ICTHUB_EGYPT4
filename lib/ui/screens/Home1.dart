
import 'package:flutter/material.dart';

import 'package:rehtjydtkuyiifykudrthag/model/Products.dart';
import 'package:rehtjydtkuyiifykudrthag/network/network request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (NetworkRequest.isLoading) {
      Future.delayed(Duration.zero, () async {
        var data = await NetworkRequest.getData();
        setState(() {
          NetworkRequest.products = data;
          NetworkRequest.isLoading = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkRequest.isLoading ?

    const Center(child: CircularProgressIndicator()) : Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:2),
          child: GridView.builder(
            itemCount: NetworkRequest.products.length,
            itemBuilder: (BuildContext context, int index) {

              return TextAndIcon(

                products: NetworkRequest.products[index],
              );

            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ),
      ),
    );
  }
}
