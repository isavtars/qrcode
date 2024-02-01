import 'package:flutter/material.dart';
import 'package:flutterdemo/Screen/home.dart';
import 'package:get/get.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.ssid, required this.password});

  final String ssid, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.to(() => const HomeScreen());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          const Icon(
            Icons.wifi,
            color: Colors.blue,
            size: 52,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Ssid:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                ssid,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Password:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                password,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class ResultScreen1 extends StatelessWidget {
  const ResultScreen1({super.key, required this.result});

  final String result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.to(() => const HomeScreen());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
          child: Column(
        children: [
          Text(" $result"),
        ],
      )),
    );
  }
}
