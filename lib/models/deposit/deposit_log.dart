import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

enum DepositStatus {
  pending(1),
  success(2),
  cancel(3);

  const DepositStatus(this.code);
  final int code;

  factory DepositStatus.fromCode(int? code) {
    return DepositStatus.values.firstWhereOrNull((e) => e.code == code) ??
        pending;
  }

  Color get color {
    return switch (this) {
      DepositStatus.pending => Colors.blue,
      DepositStatus.success => Colors.green,
      DepositStatus.cancel => Colors.red,
    };
  }
}

class DepositLog {
  const DepositLog({
    required this.paymentMethod,
    required this.uid,
    required this.trxNumber,
    required this.amount,
    required this.charge,
    required this.payable,
    required this.exchangeRate,
    required this.finalAmount,
    required this.statusCode,
    required this.feedback,
    required this.customInfo,
    required this.readableTime,
    required this.dateTime,
    required this.paymentUrl,
  });

  final PaymentMethod paymentMethod;
  final String uid;
  final String trxNumber;
  final String amount;
  final String charge;
  final String payable;
  final num exchangeRate;
  final num finalAmount;
  final int statusCode;
  final String? feedback;
  final QMap? customInfo;
  final String readableTime;
  final String dateTime;
  final String? paymentUrl;

  DepositStatus get status => DepositStatus.fromCode(statusCode);

  factory DepositLog.fromMap(Map<String, dynamic> map, [dynamic url]) {
    return DepositLog(
      paymentMethod: PaymentMethod.fromMap(map['payment_method']),
      uid: map['uid'],
      trxNumber: map['trx_number'],
      amount: map['amount'] ?? 'n/a',
      charge: map['charge'] ?? 'n/a',
      payable: map['payable'] ?? 'n/a',
      exchangeRate: map.parseNum('exchange_rate'),
      finalAmount: map.parseNum('final_amount'),
      statusCode: map.parseInt('status'),
      feedback: map['feedback'],
      customInfo: map['custom_info'],
      readableTime: map['human_readable_time'],
      dateTime: map['date_time'],
      paymentUrl: url is String ? url : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'payment_method': paymentMethod.toMap(),
      'uid': uid,
      'trx_number': trxNumber,
      'amount': amount,
      'charge': charge,
      'payable': payable,
      'exchange_rate': exchangeRate,
      'final_amount': finalAmount,
      'status': statusCode,
      'feedback': feedback,
      'custom_info': customInfo,
      'human_readable_time': readableTime,
      'date_time': dateTime,
      'payment_url': paymentUrl,
    };
  }
}
