import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:seller_management/features/payment/repository/payment_repo.dart';
import 'package:seller_management/features/payment/view/web_view_page.dart';
import 'package:seller_management/main.export.dart';

import '../../crypto/encrypter.dart';
import 'nagad_payment_repo.dart';

final nagadPaymentCtrlProvider =
    NotifierProviderFamily<NagadPaymentCtrlNotifier, String, DepositLog>(
        NagadPaymentCtrlNotifier.new);

class NagadPaymentCtrlNotifier extends FamilyNotifier<String, DepositLog> {
  final _encrypter = KEncrypter();

  /// initialize NAGAD payment
  Future initializePayment(BuildContext context) async {
    try {
      /// generate hash
      final hash = _encrypter.generateHashString(_orderId);

      /// sensitive data for NAGAD request body
      final sensitiveData = NagadInitSensitiveData(
        merchantId: _cred.merchantId,
        dateTime: _getTimeStamp,
        orderId: _orderId,
        challenge: hash,
      ).toJson();

      /// encrypt sensitive data with public key
      /// and sign with private key
      final encryptedData =
          _encrypter.encryptWithPublicKey(sensitiveData, _cred.publicKey);
      final signature =
          _encrypter.signWithPrivateKey(sensitiveData, _cred.privateKey);

      final body = NagadInitPaymentBody(
        accountNumber: _cred.merchantNumber,
        dateTime: _getTimeStamp,
        sensitiveData: encryptedData,
        signature: signature,
      );

      /// initialize payment request to Nagad api
      final response = await _repo.initializePayment(_orderId, body);

      NagadInitDecryptedData? initData;

      response.fold((l) => null, (r) => initData = r);
      if (initData == null) return;

      /// confirm payment request and get webview url
      final url = await _confirmPayment(initData!);
      if (url == null) {
        return Toaster.showError('Something went wrong').andReturn(null);
      }

      final browser = PaymentBrowser(
        title: 'Nagad Payment',
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

  /// verify payment request and complete checkout
  Future executePayment(BuildContext context, Uri? uri) async {
    if (uri == null) return;

    final body = uri.queryParameters;
    final callBack = '${arg.paymentMethod.callbackUrl}/${arg.trxNumber}';

    await PaymentRepo().confirmPayment(context, body, callBack);
  }

  String get _orderId => arg.trxNumber.replaceAll('#', '');

  String get _callbackUrl => 'https://callback.com/payment/callback';

  NagadCredentials get _cred =>
      NagadCredentials.fromMap(arg.paymentMethod.parameters);

  NagadPaymentRepo get _repo => ref.watch(nagadRepoProvider(_cred));

  /// confirm payment request and get webview url
  Future<String?> _confirmPayment(NagadInitDecryptedData data) async {
    /// set payment reference id to state to letter
    state = data.referenceId;

    /// sensitive data for NAGAD payment request confirm body
    final sensitive = NagadConfirmSensitiveData(
      merchantId: _cred.merchantId,
      orderId: _orderId,
      challenge: data.challenge,
      amount: arg.finalAmount.toString(),
    ).toJson();

    /// encrypt sensitive data with public key
    /// and sign with private key
    final encryptedData =
        _encrypter.encryptWithPublicKey(sensitive, _cred.publicKey);
    final signature =
        _encrypter.signWithPrivateKey(sensitive, _cred.privateKey);

    final body = NagadConfirmPaymentBody(
      sensitiveData: encryptedData,
      signature: signature,
      additionalInfo: {},
      callbackURL: _callbackUrl,
    );

    /// confirm payment request to Nagad api
    final response = await _repo.confirmPayment(data.referenceId, body);

    String? url;

    response.fold((l) => null, (r) => url = r);

    return url;
  }

  String get _getTimeStamp {
    final now = DateTime.now();
    final timeStamp = DateFormat('yyyyMMddHHmmss').format(now);
    return timeStamp;
  }

  @override
  String build(DepositLog arg) {
    return '';
  }
}
