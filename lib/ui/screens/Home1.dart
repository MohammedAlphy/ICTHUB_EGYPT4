import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_cubit.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_state.dart';

import 'package:rehtjydtkuyiifykudrthag/model/Products.dart';
import 'package:rehtjydtkuyiifykudrthag/network/network request.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

//  @override
  // void initState() {
  // if (NetworkRequest.isLoading) {
  //   Future.delayed(Duration.zero, () async {
  //   var data = await NetworkRequest.getData();
  //   setState(() {
  //   NetworkRequest.products = data;
  //   NetworkRequest.isLoading = false;
  // });
  //   });
  // }
  // super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        toolbarHeight: 100,
        title: const Text('Welcome to\nEGYDYNAMIC..',
        style: TextStyle(
            fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        ),
        iconTheme: IconThemeData(size: 10),
        actions: [
          Image.asset(
            'assets/images/img.png',
        width: 70,

          ),
        ],
      ) ,
      body: BlocConsumer<AppCubitA, AppStateA>(listener: (context, state) {
        if (state is ErrorState) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Something went wrong 0_0'),
              );
            },
          );
          print('Something went wrong 0_0');
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DoneState ||
            context.read<AppCubitA>().products.isNotEmpty) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: GridView.builder(
                itemCount: context.read<AppCubitA>().products.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextAndIcon(
                    products: context.read<AppCubitA>().products[index],
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              ),
            ),
          );
        } else {
          return const Center(child: Text('Error404'));
        }
      }),
    );
  }
}
