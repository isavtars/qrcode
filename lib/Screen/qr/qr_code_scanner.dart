import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterdemo/Screen/qr/qr_result_screen.dart';
import 'package:flutterdemo/Screen/qr/qr_scanner_overlay.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../models/wifi_data_m.dart';

class QrcodeScanner extends StatefulWidget {
  const QrcodeScanner({super.key});

  @override
  State<QrcodeScanner> createState() => _QrcodeScannerState();
}

class _QrcodeScannerState extends State<QrcodeScanner> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            // fit: BoxFit.contain,
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                if (barcode.rawValue!.isNotEmpty) {
                  if (isWiFiQRCode(barcode.rawValue!)) {
                    _navigateToResultScreen(barcode.rawValue!);
                  } else {
                    _navigateToResultScreen1(barcode.rawValue!);
                  }

                  cameraController.stop();
                }
              }
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
        ],
      ),
    );
  }

  bool isWiFiQRCode(String rawResult) {
    return rawResult.toUpperCase().contains('WIFI:');
  }

  Future<void> _navigateToResultScreen1(String barcodeValue) async {
    await Get.to(() => ResultScreen1(result: barcodeValue));
    cameraController.stop();
  }

  Future<void> _navigateToResultScreen(String barcodeValue) async {
    WiFiData wiFiData = parseWiFiQRCode(barcodeValue);
    await Get.to(
        () => ResultScreen(ssid: wiFiData.ssid, password: wiFiData.password));
  }

  WiFiData parseWiFiQRCode(String rawResult) {
    String ssid = '';
    String password = '';

    final List<String> keyValuePairs = rawResult.split(';');
    for (final pair in keyValuePairs) {
      final List<String> parts = pair.split(':');
      if (parts.length == 2) {
        final String key = parts[0].trim().toUpperCase();
        final String value = parts[1].trim();

        switch (key) {
          case 'S':
            ssid = value;
            break;
          case 'P':
            password = value;
            break;
        }
      }
    }

    return WiFiData(ssid, password);
  }
}
