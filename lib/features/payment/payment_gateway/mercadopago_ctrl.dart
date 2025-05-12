// cspell:words mercadopago
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';

import '../../../main.export.dart';
import '../repository/payment_repo.dart';
import '../view/web_view_page.dart';

final mercadoPaymentCtrlProvider =
    NotifierProviderFamily<MercadopagoPaymentCtrl, QMap, DepositLog>(
        MercadopagoPaymentCtrl.new);

class MercadopagoPaymentCtrl extends FamilyNotifier<QMap, DepositLog> {
  Future<void> initializePayment(BuildContext context) async {
    try {
      final data = await _createPayment();

      state = data;
      final url = data['init_point']?.toString() ?? '';

      if (url.isEmpty) {
        return Toaster.showError('Something went wrong').andReturn(null);
      }

      final browser = PaymentBrowser(
        title: 'Mercado Pago Payment',
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

      Toaster.remove();
    } on DioException catch (e) {
      Toaster.showError(e.message);
    }
  }

  Future<void> executePayment(BuildContext context, Uri? uri) async {
    if (uri == null) return;
    final body = {...uri.queryParameters, ...state};

    final callBack = '${arg.paymentMethod.callbackUrl}/${arg.trxNumber}';

    await PaymentRepo().confirmPayment(context, body, callBack);
  }

  String get _callbackUrl => 'https://callback.com/payment/callback';

  _createPayment() async {
    final seller =
        await ref.read(dashBoardCtrlProvider.selectAsync((s) => s.seller));

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer ${_mercadoCreds.accessToken}',
    };

    final body = {
      "items": [
        {
          "id": arg.trxNumber,
          "title": "Payment",
          "description": 'Payment from user',
          "quantity": 1,
          "currency_id": arg.paymentMethod.currency.name,
          "unit_price": arg.finalAmount,
        }
      ],
      "payer": {
        "email": seller.email,
      },
      "back_urls": {
        "success": _callbackUrl,
        "pending": '',
        "failure": _callbackUrl,
      },
      "notification_url": "http://notificationurl.com",
      'auto_return': 'approved',
    };
    final response = await _dio.post(
      'https://api.mercadopago.com/checkout/preferences',
      options: Options(headers: headers),
      data: body,
    );

    return response.data;
  }

  Dio get _dio => Dio()..interceptors.add(Logger.dioLogger());

  MercadoCreds get _mercadoCreds =>
      MercadoCreds.fromMap(arg.paymentMethod.parameters);

  @override
  QMap build(DepositLog arg) {
    return {};
  }
}
