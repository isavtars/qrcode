import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'qr/qr_code_scanner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const QrcodeScanner());
                  },
                  icon: const Icon(
                    Icons.qr_code,
                    size: 37,
                  )),
              const Text(
                "Qr code",
                style: TextStyle(fontSize: 18),
              )
            ],
          )
        ]),
      ),
    );
  }
}
