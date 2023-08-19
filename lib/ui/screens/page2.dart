import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  final String input1;
  const Page2({super.key, required this.input1});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final TextEditingController input1Controller = TextEditingController();
  final TextEditingController input2Controller = TextEditingController();
  double sum = 0;

  void getSum() {
    setState(() {
      sum = double.parse(input1Controller.text) +
          double.parse(input2Controller.text);
    });
  }

  @override
  void initState() {
    input1Controller.text = widget.input1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'sum = $sum',
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
                controller: input1Controller,
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
                controller: input2Controller,
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
                getSum();
                print(sum.toString());
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
      ),
    );
  }
}