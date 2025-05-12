// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../main.export.dart';
import '../repository/payment_repo.dart';
import '../view/web_view_page.dart';

final bkashPaymentCtrlProvider =
    NotifierProviderFamily<BkashPaymentCtrl, String?, DepositLog>(
        BkashPaymentCtrl.new);

class BkashPaymentCtrl extends FamilyNotifier<String?, DepositLog> {
  initializePayment(BuildContext context) async {
    try {
      Toaster.showLoading('Redirecting...');
      final token = await _createToken();
      state = token;

      final headers = {
        "accept": 'application/json',
        "Authorization": token,
        "X-APP-Key": _bkashCreds.apiKey,
        'content-type': 'application/json'
      };
      final body = {
        "mode": '0011',
        "payerReference": ' ',
        "callbackURL": _callbackUrl,
        "amount": arg.finalAmount,
        "currency": arg.paymentMethod.currency.name,
        "intent": 'sale',
        "merchantInvoiceNumber": arg.trxNumber,
      };

      final response = await _dio.post(
        "$_baseUrl/tokenized/checkout/create",
        options: Options(headers: headers),
        data: json.encode(body),
      );

      final url = response.data['bkashURL'] ?? '';

      if (url.isEmpty) {
        return Toaster.showError('Something went wrong').andReturn(null);
      }

      final browser = PaymentBrowser(
        title: 'Bkash Payment',
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
      Toaster.showError(e.message);
    }
  }

  Future<void> executePayment(BuildContext context, Uri? uri) async {
    if (uri == null) return;

    final body = uri.queryParameters;
    final callBack = '${arg.paymentMethod.callbackUrl}/${arg.trxNumber}';

    await PaymentRepo().confirmPayment(context, body, callBack);
  }

  BkashCredentials get _bkashCreds =>
      BkashCredentials.fromMap(arg.paymentMethod.parameters);

  String get _baseUrl =>
      "https://tokenized.${_bkashCreds.isSandbox ? "sandbox" : "pay"}.bka.sh/v1.2.0-beta";

  Dio get _dio => Dio()..interceptors.add(Logger.dioLogger());

  String get _callbackUrl => 'https://callback.com/payment/callback';

  Future<String?> _createToken() async {
    try {
      final headers = {
        "accept": 'application/json',
        "username": _bkashCreds.userName,
        "password": _bkashCreds.password,
        'content-type': 'application/json'
      };
      final body = {
        "app_key": _bkashCreds.apiKey,
        "app_secret": _bkashCreds.apiSecret,
      };
      final response = await _dio.post(
        "$_baseUrl/tokenized/checkout/token/grant",
        options: Options(headers: headers),
        data: json.encode(body),
      );

      return response.data['id_token'];
    } on DioException catch (e) {
      Toaster.showError(e.message);
      return null;
    }
  }

  @override
  String build(DepositLog arg) {
    return '';
  }
}
