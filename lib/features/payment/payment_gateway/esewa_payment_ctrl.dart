// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/widgets.dart';
import 'package:seller_management/features/payment/repository/payment_repo.dart';
import 'package:seller_management/main.export.dart';

final eSewaPaymentCtrlProvider =
    NotifierProviderFamily<ESewaPaymentCtrlNotifier, String, DepositLog>(
        ESewaPaymentCtrlNotifier.new);

class ESewaPaymentCtrlNotifier extends FamilyNotifier<String, DepositLog> {
  Future<void> initiatePayment(BuildContext context) async {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: _creds.isSandbox ? Environment.test : Environment.live,
          clientId: _creds.clientId,
          secretId: _creds.clientSecret,
        ),
        esewaPayment: EsewaPayment(
          productId: arg.trxNumber,
          productName: arg.trxNumber,
          productPrice: arg.finalAmount.toString(),
          callbackUrl: Endpoints.baseUrl,
        ),
        onPaymentSuccess: (data) async {
          Logger.json(data.toJson(), 'success');
          Toaster.showInfo('please wait ...');
          await onPaymentSuccess(data, context);
        },
        onPaymentFailure: (data) async {
          Logger(":::FAILURE::: => $data");
          Toaster.showInfo('please wait ...');
          await _confirm(context);
        },
        onPaymentCancellation: (data) async {
          Logger(":::CANCELLATION::: => $data");
        },
      );
    } catch (e, s) {
      Logger.ex(e, s);
    }
  }

  Future<void> onPaymentSuccess(
    EsewaPaymentSuccessResult data,
    BuildContext context,
  ) async {
    final jsonData = {"status": data.status};
    await _confirm(context, jsonData);
  }

  ESewaCredentials get _creds =>
      ESewaCredentials.fromMap(arg.paymentMethod.parameters);

  Future<void> _confirm(BuildContext context, [QMap? data]) async {
    final trx = arg.trxNumber;
    final status = data == null ? 'failed' : 'success';

    String callback = '${arg.paymentMethod.callbackUrl}/$trx/$status';

    String encodedData = base64Encode(utf8.encode(jsonEncode(data)));

    await PaymentRepo()
        .confirmPayment(context, {'data': encodedData}, callback);
  }

  @override
  String build(DepositLog arg) {
    return '';
  }
}
