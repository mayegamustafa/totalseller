// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';

import '../../../main.export.dart';
import '../repository/payment_repo.dart';
import '../view/web_view_page.dart';

final stripePaymentCtrlProvider =
    NotifierProviderFamily<StripePaymentCtrlNotifier, String, DepositLog>(
        StripePaymentCtrlNotifier.new);

class StripePaymentCtrlNotifier extends FamilyNotifier<String, DepositLog> {
  @override
  String build(DepositLog arg) {
    return '';
  }

  Dio get _dio => Dio()..interceptors.add(Logger.dioLogger());

  String get _callbackUrl => 'https://callback.com/payment/callback';

  StripeParam get _cred => StripeParam.fromMap(arg.paymentMethod.parameters);

  Future<void> initializePayment(BuildContext context) async {
    try {
      final customer = await _createCustomer();
      final session = await _createSession(customer['id']);

      state = session['id'];
      final url = session['url']?.toString() ?? '';

      if (url.isEmpty) {
        return Toaster.showError('Something went wrong').andReturn(null);
      }

      final browser = PaymentBrowser(
        title: 'Stripe Payment',
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
      Toaster.showError(e.response?.data['message']);
    }
  }

  // creates payment intent from stripe API
  Future<Map<String, dynamic>> _createCustomer() async {
    const api = 'https://api.stripe.com/v1/customers';
    final seller =
        await ref.read(dashBoardCtrlProvider.selectAsync((s) => s.seller));

    final body = {
      'name': seller.name,
      'email': seller.email,
      'phone': seller.phone,
      'shipping': {
        'name': seller.address?.address,
        'address': {
          'line1': seller.address?.address,
          'city': seller.address?.city,
          'postal_code': seller.address?.zip,
        },
      },
    };

    final option = Options(
      headers: {
        'Authorization': 'Bearer ${_cred.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final response = await _dio.post(api, data: body, options: option);

    return response.data;
  }

  int get _finalAmount => arg.finalAmount.round();

  Future<Map<String, dynamic>> _createSession(customerID) async {
    final currencyCode = arg.paymentMethod.currency.name;
    const api = 'https://api.stripe.com/v1/checkout/sessions';

    final body = {
      'mode': 'payment',
      'customer': customerID,
      'success_url': '$_callbackUrl?type=success',
      'cancel_url': '$_callbackUrl?type=failed',
      'line_items': [
        {
          'quantity': 1,
          'price_data': {
            'currency': currencyCode.toLowerCase(),
            'unit_amount': (_finalAmount * 100).toInt(),
            'product_data': {'name': arg.uid},
          },
        }
      ],
    };

    final option = Options(
      headers: {
        'Authorization': 'Bearer ${_cred.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final response = await _dio.post(api, data: body, options: option);

    Logger.json(response.data, 'SESSION');

    return response.data;
  }

  Future<void> executePayment(BuildContext context, Uri? url) async {
    Logger(url, 'url');

    if (url == null) return;

    final type = url.queryParameters['type'];

    final body = {'payment_id': state};

    final trx = arg.trxNumber;
    final callbackUrl = '${arg.paymentMethod.callbackUrl}/$trx/$type';

    Logger.json(body);

    await PaymentRepo().confirmPayment(context, body, callbackUrl);
  }
}
