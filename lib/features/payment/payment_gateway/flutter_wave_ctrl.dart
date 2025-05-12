import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';

import '../../../main.export.dart';
import '../repository/payment_repo.dart';
import '../view/web_view_page.dart';

final flutterWaveCtrlProvider =
    NotifierProviderFamily<FlutterWaveCtrlNotifier, String, DepositLog>(
        FlutterWaveCtrlNotifier.new);

class FlutterWaveCtrlNotifier extends FamilyNotifier<String, DepositLog> {
  final _paymentUrl = "/payments";

  Future<void> initializePayment(BuildContext context) async {
    final seller =
        await ref.read(dashBoardCtrlProvider.selectAsync((s) => s.seller));

    final data = {
      "tx_ref": arg.trxNumber,
      "publicKey": _cred.publicKey,
      "amount": arg.finalAmount.round().toString(),
      "currency": arg.paymentMethod.currency.name,
      "payment_options": "ussd, card, barter, payattitude",
      "redirect_url": _callbackUrl,
      "customizations": {"title": "Flutter Wave Payment"},
      'customer': {
        "email": seller.email,
        "phonenumber": seller.phone,
        "name": seller.name,
      }
    };

    final headers = {
      HttpHeaders.authorizationHeader: _cred.publicKey,
      HttpHeaders.contentTypeHeader: "application/json",
    };

    final response = await _dio.post(
      _baseUrl + _paymentUrl,
      options: Options(headers: headers),
      data: data,
    );
    final body = response.data;

    if (response.statusCode != 200) return;

    if (body['status'] == 'error') return;
    if (!context.mounted) return;

    final url = body['data']?['link']?.toString() ?? '';

    if (url.isEmpty) {
      return Toaster.showError('Something went wrong').andReturn(null);
    }

    final browser = PaymentBrowser(
      title: 'Flutter Wave Payment',
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
  }

  Future<void> executePayment(context, Uri? uri) async {
    final data = uri!.queryParameters;
    final callBack =
        '${arg.paymentMethod.callbackUrl}/${data['tx_ref']}/${data['status']}';

    await PaymentRepo().confirmPayment(context, data, callBack);
  }

  Dio get _dio => Dio()..interceptors.add(Logger.dioLogger());

  String get _callbackUrl => 'https://callback.com/payment/callback';

  FlutterWaveCredentials get _cred =>
      FlutterWaveCredentials.fromMap(arg.paymentMethod.parameters);

  String get _baseUrl => _cred.isSandbox
      ? "https://ravesandboxapi.flutterwave.com/v3/sdkcheckout/"
      : "https://api.ravepay.co/v3/sdkcheckout";

  @override
  String build(DepositLog arg) {
    return '';
  }
}
