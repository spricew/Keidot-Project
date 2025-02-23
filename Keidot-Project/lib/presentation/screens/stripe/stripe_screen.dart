import 'package:flutter/material.dart';

class HomePageStripe extends StatefulWidget {
  const HomePageStripe({super.key});

  @override
  State<HomePageStripe> createState() => _HomePageStripeState();
}

class _HomePageStripeState extends State<HomePageStripe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: ()
          {

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text(
            'Pay Now',
            style: TextStyle(
              color: Colors.white,
            ),
          ))
        ],
      ),),
    );
  }
}