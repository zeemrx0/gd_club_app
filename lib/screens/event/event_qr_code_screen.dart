import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventQRCodeScreen extends StatelessWidget {
  static const routeName = '/event-qr-code';

  const EventQRCodeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  const Text(
                    'Đưa mã QR cho người phụ trách quét mã',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ColoredBox(
                    color: Colors.white,
                    child: QrImage(
                      data: 'Hello',
                      size: 300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
