// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:payment_module/payment_module.dart';
import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';

import '../../../main.export.dart';
import '../repository/payment_repo.dart';

final aamarPayCtrlProvider =
    NotifierProviderFamily<AamarPayCtrlNotifier, String, DepositLog>(
        AamarPayCtrlNotifier.new);

class AamarPayCtrlNotifier extends FamilyNotifier<String, DepositLog> {
  String get _storeId => arg.paymentMethod.parameters['store_id'];
  String get _storeKey => arg.paymentMethod.parameters['signature_key'];
  String get _isSand => arg.paymentMethod.parameters['is_sandbox'];

  final _module = const PaymentModule();

  Future<String?> payWithAamarPay(BuildContext context) async {
    final seller =
        await ref.read(dashBoardCtrlProvider.selectAsync((s) => s.seller));

    final config = AamarPayConfig(
      email: seller.email,
      mobile: seller.phone,
      name: seller.name,
      signature: _storeKey,
      storeID: _storeId,
      amount: arg.finalAmount.toString(),
      transactionId: arg.trxNumber,
      description: 'Deposit ${arg.trxNumber}',
      isSandBox: _isSand == '1',
    );
    await _module.payWithAamarPay(
      context,
      config: config,
      urlCallback: (status, url) async {
        Logger('$url ::  ${status.name}}', 'status');

        if (status == AamarPayStatus.success) {
          await _executePayment(context, 'success');
        }
        if (status == AamarPayStatus.failed) {
          await _executePayment(context, 'failed');
        }
      },
      eventCallback: (event, url) {
        Logger('$url ::  ${event.name}}', 'event');
      },
    );
    return null;
  }

  Future<void> _executePayment(BuildContext context, String type) async {
    final body = {'currency': arg.paymentMethod.currency.name};

    final trx = arg.trxNumber;
    final callbackUrl = '${arg.paymentMethod.callbackUrl}/$trx/$type';

    await PaymentRepo().confirmPayment(context, body, callbackUrl);
  }

  @override
  String build(DepositLog arg) {
    return '';
  }
}
