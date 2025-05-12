// import 'package:pdf/widgets.dart';

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:seller_management/main.export.dart';

class PDFCtrl {
  Future<String> androidDownloadDir(String fileName) async {
    final isAndroid = Platform.isAndroid;
    final path = isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getApplicationDocumentsDirectory();

    final fullPath = '${path.path}${Platform.pathSeparator}$fileName';
    return fullPath;
  }

  FutureReport<String> saveOrderPdf(OrderModel order) async {
    try {
      final info = await DeviceInfoPlugin().androidInfo;
      final android = info.version.release.asInt;

      final permission =
          android < 13 ? Permission.storage : Permission.manageExternalStorage;

      final isGranted = await permission.request().isGranted;
      if (!isGranted) {
        openAppSettings();
        return left(const Failure('Permission denied'));
      }

      final pdf = await generateOrderPDF(order);

      final filePath = await saveAndroid(pdf, order.orderId);
      return right(filePath);
    } catch (e, st) {
      Logger.ex(e, st);
      return left(Failure(e.toString(), stackTrace: st));
    }
  }

  Future<String> saveAndroid(pw.Document pdf, String fileName) async {
    final path = await androidDownloadDir('$fileName.pdf');

    final file = File(path);
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    await file.writeAsBytes(await pdf.save());

    return path;
  }

  Future<pw.Image?> loadImage(String? url) async {
    if (url == null) return null;
    final netImage = await networkImage(url);

    return pw.Image(
      netImage,
      height: 100,
      width: 100,
      fit: pw.BoxFit.contain,
    );
  }

  Future<pw.Document> generateOrderPDF(OrderModel order) async {
    final stamp = await loadImage(order.invoiceLogo);
    final font = await PdfGoogleFonts.robotoBlack();
    final pdf = pw.Document(
      author: AppDefaults.appName,
      title: 'Invoice',
      theme: pw.ThemeData(
        defaultTextStyle: pw.TextStyle(
          fontSize: 10,
          font: font,
          renderingMode: PdfTextRenderingMode.fill,
        ),
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a5,
        margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        build: (pw.Context context) {
          return [
            PDFPages.orderPDFPage(context, stamp, order),
          ];
        },
      ),
    );
    return pdf;
  }
}
