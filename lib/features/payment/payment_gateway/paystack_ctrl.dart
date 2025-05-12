// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';
import 'package:seller_management/features/payment/repository/payment_repo.dart';
import 'package:seller_management/main.export.dart';

import '../view/web_view_page.dart';

final paystackCtrlProvider =
    NotifierProviderFamily<PaystackCtrlNotifier, String?, DepositLog>(
        PaystackCtrlNotifier.new);

class PaystackCtrlNotifier extends FamilyNotifier<String?, DepositLog> {
  final _baseUrl = 'https://api.paystack.co/transaction';
  final _dio = Dio()..interceptors.add(Logger.dioLogger());

  Future<void> initializePayment(BuildContext context) async {
    try {
      final headers = {'Authorization': 'Bearer ${_cred.secretKey}'};

      final email = await ref
          .read(dashBoardCtrlProvider.selectAsync((s) => s.seller.email));

      final response = await _dio.post(
        '$_baseUrl/initialize',
        options: Options(headers: headers),
        data: {
          'email': email,
          'amount': arg.finalAmount.round(),
          'callback_url': _callbackUrl,
        },
      );

      state = response.data['data']['reference'];
      final url = response.data['data']?['authorization_url'] ?? '';
      if (url.isEmpty) {
        return Toaster.showError('Something went wrong').andReturn(null);
      }

      final browser = PaymentBrowser(
        title: 'Paystack Payment',
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
    } on DioException catch (e) {
      Toaster.showError(
        e.response?.data['message'] ?? 'Failed to initialize payment',
      );
    }
  }

  Future<void> executePayment(BuildContext context, Uri? url) async {
    final body = url!.queryParameters;
    final trx = arg.trxNumber;
    final callbackUrl = '${arg.paymentMethod.callbackUrl}/$trx';
    await PaymentRepo().confirmPayment(context, body, callbackUrl);
  }

  PaystackCredentials get _cred =>
      PaystackCredentials.fromMap(arg.paymentMethod.parameters);

  String get _callbackUrl => 'https://callback.com/payment/callback';

  @override
  String? build(DepositLog arg) {
    return '';
  }
}
