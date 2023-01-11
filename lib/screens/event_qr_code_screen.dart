import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventQRCodeScreen extends StatelessWidget {
  static const routeName = "/qr-code";

  const EventQRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check in"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 40),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Đưa mã QR cho người phụ trách quét mã",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              QrImage(
                data: "Hello",
                version: QrVersions.auto,
                size: 300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
