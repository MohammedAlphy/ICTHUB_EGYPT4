import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_cubit.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_cubit.dart';
import 'package:rehtjydtkuyiifykudrthag/cubit/my_app_state.dart';

class Page2 extends StatelessWidget {
  final String input1;

  const Page2({super.key, required this.input1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubitA, AppStateA>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'sum = ${context.read<AppCubitA>().sum}',
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: context.read<AppCubitA>().input1Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Input 1',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: context.read<AppCubitA>().input2Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Input 2',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      alignment: Alignment.center,
                      maximumSize: const Size(200, 60),
                      padding: const EdgeInsets.all(10)),
                  onPressed: () {
                    context.read<AppCubitA>().getSum();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Get sum'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.calculate_outlined),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}