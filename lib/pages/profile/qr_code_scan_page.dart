import 'package:baas_study/dao/passport_dao.dart';
import 'package:baas_study/pages/profile/qr_code_login_confirm_page.dart';
import 'package:baas_study/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class QrCodeScanPage extends StatefulWidget {
  @override
  _QrCodeScanPageState createState() => _QrCodeScanPageState();
}

class _QrCodeScanPageState extends State<QrCodeScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String qrText = "";
  QRViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        Uri url = Uri.parse(qrText);
        if (url.host == 'm.baasstudy.com' &&
            url.queryParameters['uuid'] != null) {
          controller.pauseCamera();
          _qrCodeScan(url.queryParameters['uuid']);
        }
      });
    });
  }

  Future<Null> _qrCodeScan(String uuid) async {
    try {
      bool scan = await PassportDao.qrCodeScan(uuid);
      if (scan) {
        Navigator.pushReplacement(
          context,
          SlideTopRoute(QrCodeLoginConfirmPage(uuid: uuid)),
        );
      } else {
        controller.resumeCamera();
      }
    } catch (e) {
      print('QrCodeScanError:$e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
