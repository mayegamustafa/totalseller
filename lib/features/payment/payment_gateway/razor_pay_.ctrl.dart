// // ignore_for_file: use_build_context_synchronously
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';

// import '../../../main.export.dart';
// import '../repository/payment_repo.dart';

// final razorPayPaymentCtrlProvider =
//     Provider.family.autoDispose<RazorPayPaymentCtrl, DepositLog>((ref, data) {
//   return RazorPayPaymentCtrl(ref, data);
// });

// class RazorPayPaymentCtrl {
//   RazorPayPaymentCtrl(this._ref, this.depositLog);

//   final DepositLog depositLog;
//   final razorPay = Razorpay();

//   final Ref _ref;

//   Future<void> initializePayment(BuildContext context) async {
//     razorPay.on(
//       Razorpay.EVENT_PAYMENT_SUCCESS,
//       (res) => _handlePaymentSuccess(context, res),
//     );

//     razorPay.on(
//       Razorpay.EVENT_PAYMENT_ERROR,
//       (res) => _handlePaymentError(context, res),
//     );

//     razorPay.on(
//       Razorpay.EVENT_EXTERNAL_WALLET,
//       (res) => _handleExternalWallet(context, res),
//     );

//     final seller =
//         await _ref.read(dashBoardCtrlProvider.selectAsync((s) => s.seller));

//     final amount = depositLog.finalAmount;
//     final orderId = await createOrder();

//     final options = {
//       'key': _creds.razorpayKey,
//       'amount': (amount * 100).toInt(),
//       'name': seller.name,
//       'order_id': orderId,
//       'currency': depositLog.paymentMethod.currency.name,
//       'description':
//           'Deposit ${depositLog.paymentMethod.currency.name} to ${seller.name}',
//       'prefill': {
//         'name': seller.name,
//         'contact': seller.phone,
//         'email': seller.email,
//       }
//     };

//     razorPay.open(options);
//   }

//   Future<String> createOrder() async {
//     final dio = Dio()..interceptors.add(Logger.dioLogger());

//     final amount = depositLog.finalAmount;
//     final orderBody = {
//       "amount": (amount * 100).toInt(),
//       "currency": depositLog.paymentMethod.currency.name,
//       "receipt": depositLog.trxNumber,
//     };
//     final auth = base64
//         .encode(utf8.encode('${_creds.razorpayKey}:${_creds.razorpaySecret}'));

//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Basic $auth'
//     };

//     final response = await dio.post(
//       'https://api.razorpay.com/v1/orders',
//       data: orderBody,
//       options: Options(headers: headers),
//     );

//     return response.data['id'];
//   }

//   void clear() => razorPay.clear();

//   RazorPayCredentials get _creds =>
//       RazorPayCredentials.fromMap(depositLog.paymentMethod.parameters);

//   void _handlePaymentSuccess(
//     BuildContext context,
//     PaymentSuccessResponse response,
//   ) async {
//     final data = <String, String?>{
//       'razorpay_payment_id': response.paymentId,
//       'razorpay_order_id': response.orderId,
//       'razorpay_signature': response.signature,
//     };

//     await _confirmCheckout(context, data);
//     clear();
//   }

//   void _handlePaymentError(context, PaymentFailureResponse response) async {
//     final data = <String, dynamic>{
//       'code': response.code,
//       'message': response.message,
//       'error': response.error,
//     };

//     await _confirmCheckout(context, data);
//     clear();
//   }

//   void _handleExternalWallet(context, ExternalWalletResponse response) {
//     clear();
//   }

//   // calls checkout api from backend
//   Future<void> _confirmCheckout(context, Map<String, dynamic> data) async {
//     final trx = depositLog.trxNumber;
//     final callBack = '${depositLog.paymentMethod.callbackUrl}/$trx';
//     Toaster.showLoading('Confirming Payment...');

//     await PaymentRepo().confirmPayment(context, data, callBack);
//     Toaster.remove();
//   }
// }
