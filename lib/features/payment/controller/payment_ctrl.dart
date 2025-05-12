import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_name.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../payment_gateway/payment_gateway.dart';

final paymentCtrlProvider =
    NotifierProvider<PaymentCtrl, DepositLog?>(PaymentCtrl.new);

class PaymentCtrl extends Notifier<DepositLog?> {
  @override
  DepositLog? build() {
    return null;
  }

  Future<void> initializePayment(BuildContext context, DepositLog log) async {
    state = log;

    if (log.paymentUrl != null) {
      await launchUrlString(log.paymentUrl!);
      if (!context.mounted) return;
      RouteNames.afterPayment.goNamed(context, query: {'status': 'w'});
      return;
    }

    final res = await switch (log.paymentMethod.uniqueCode) {
      'STRIPE101' => _payWithStripe(context),
      'PAYPAL102' => _payWithPaypal(context),
      'PAYSTACK103' => _payWithPayStack(context),
      'FLUTTERWAVE105' => _payWithFlutterWave(context),
      'RAZORPAY106' => _payWithRazorPay(context),
      'INSTA106' => _payWithInstaMojo(context),
      'BKASH102' => _payWithBkash(context),
      'NAGAD104' => _payWithNagad(context),
      'MERCADO101' => _payWithMercado(context),
      'AAMARPAY107' => _payWithAamarPay(context),
      'ESEWA107' => _payWithEsewa(context),
      _ => Future(() => 'Unsupported Payment Method'),
    };

    if (res != null) Toaster.showInfo(res);
  }

  Future<String?> _payWithStripe(BuildContext context) async {
    final stripeCtrl = ref.read(stripePaymentCtrlProvider(state!).notifier);
    await stripeCtrl.initializePayment(context);
    return null;
  }

  Future<String?> _payWithPaypal(BuildContext context) async {
    final paypalCtrl = ref.read(paypalPaymentCtrlProvider(state!).notifier);
    await paypalCtrl.initializePayment(context);
    return null;
  }

  Future<String?> _payWithPayStack(BuildContext context) async {
    final payStackCtrl = ref.read(paystackCtrlProvider(state!).notifier);
    await payStackCtrl.initializePayment(context);
    return null;
  }

  Future<String?> _payWithFlutterWave(BuildContext context) async {
    await ref
        .read(flutterWaveCtrlProvider(state!).notifier)
        .initializePayment(context);
    return null;
  }

  Future<String?> _payWithRazorPay(BuildContext context) async {
    // await ref
    //     .read(razorPayPaymentCtrlProvider((state!)))
    //     .initializePayment(context);
    return 'RazorPay is not available';
  }

  Future<String?> _payWithInstaMojo(BuildContext context) async {
    await ref
        .read(instaMojoCtrlProvider(state!).notifier)
        .initializePayment(context);
    return null;
  }

  Future<String?> _payWithBkash(BuildContext context) async {
    await ref
        .read(bkashPaymentCtrlProvider(state!).notifier)
        .initializePayment(context);
    return null;
  }

  Future<String?> _payWithNagad(BuildContext context) async {
    await ref
        .read(nagadPaymentCtrlProvider(state!).notifier)
        .initializePayment(context);
    return null;
  }

  Future<String?> _payWithMercado(BuildContext context) async {
    final stripeCtrl = ref.read(mercadoPaymentCtrlProvider(state!).notifier);
    await stripeCtrl.initializePayment(context);
    return null;
  }

  Future<String?> _payWithAamarPay(BuildContext context) async {
    return ref
        .read(aamarPayCtrlProvider(state!).notifier)
        .payWithAamarPay(context);
  }

  Future<String> _payWithEsewa(BuildContext context) async {
    final stripeCtrl = ref.read(eSewaPaymentCtrlProvider(state!).notifier);
    await stripeCtrl.initiatePayment(context);
    return '';
  }
}
