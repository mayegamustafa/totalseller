// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';
import 'package:seller_management/routes/routes.dart';

import '../../../main.export.dart';
import '../view/web_view_page.dart';

final instaMojoCtrlProvider =
    NotifierProviderFamily<InstaMojoCtrlNotifier, String, DepositLog>(
        InstaMojoCtrlNotifier.new);

class InstaMojoCtrlNotifier extends FamilyNotifier<String, DepositLog> {
  Future<void> initializePayment(BuildContext context) async {
    try {
      final response = await _dio.request(
        "$_baseUrl/payment-requests/",
        options: Options(method: 'POST', headers: _headers()),
        data: FormData.fromMap(await _paymentData()),
      );

      final body = response.data;

      final url = body['payment_request']?['longurl']?.toString() ?? '';
      if (url.isEmpty) {
        return Toaster.showError('Something went wrong').andReturn(null);
      }

      final browser = PaymentBrowser(
        title: 'Instamojo Payment',
        onUrlOverride: (uri, close) async {
          final url = uri.toString();
          if (url.contains(_callbackUrl)) {
            await executePayment(context, uri);
            close();
            return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
      );

      browser.openUrl(url);
    } on DioException catch (err) {
      Toaster.showError(err.message);
    }
  }

  Future<dynamic> executePayment(BuildContext context, Uri? uri) async {
    if (uri == null) return;

    final status = uri.queryParameters['payment_status'];

    RouteNames.afterPayment.goNamed(
      context,
      query: {'status': status == 'Credit' ? 's' : 'f'},
    );
  }

  Dio get _dio => Dio()..interceptors.add(Logger.dioLogger());

  String get _callbackUrl => 'https://callback.com/payment/callback';

  InstaMojoCredentials get _creds =>
      InstaMojoCredentials.fromMap(arg.paymentMethod.parameters);

  String get _baseUrl => _creds.isSandbox
      ? 'https://test.instamojo.com/api/1.1'
      : 'https://www.instamojo.com/api/1.1';

  Map<String, String> _headers() {
    final header = {
      'X-Api-Key': _creds.apiKey,
      'X-Auth-Token': _creds.authToken,
    };
    return header;
  }

  Future<Map<String, dynamic>> _paymentData() async {
    final seller =
        await ref.read(dashBoardCtrlProvider.selectAsync((s) => s.seller));
    return {
      'amount': arg.finalAmount.toString(),
      'purpose': 'Payment',
      'buyer_name': seller.name,
      'email': seller.email,
      'phone': seller.phone,
      'redirect_url': _callbackUrl,
      'webhook': '${arg.paymentMethod.callbackUrl}/${arg.trxNumber}',
      'allow_repeated_payments': 'false',
      'send_email': _creds.isSandbox ? 'false' : 'true',
      'send_sms': _creds.isSandbox ? 'false' : 'true',
    };
  }

  @override
  String build(DepositLog arg) {
    return '';
  }
}
