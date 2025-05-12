import 'package:seller_management/_core/_core.dart';
import 'package:seller_management/models/_misc/j_enum.dart';
import 'package:seller_management/models/config/kyc_config.dart';

class Config {
  const Config({
    required this.registration,
    required this.deliveryStatus,
    required this.ticketPriority,
    required this.leftCurrency,
    required this.kycVerification,
    required this.canUpdateProductStatus,
    required this.kycConfig,
    required this.deliveryPermission,
    required this.minDepositAmount,
    required this.maxDepositAmount,
  });

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      registration: map['registration'] as bool,
      deliveryStatus: JEnum.fromMap(map['delevary_status']),
      ticketPriority: JEnum.fromMap(map['ticket_priority']),
      leftCurrency: map.parseBool('currency_position_is_left'),
      kycVerification: map.parseBool('seller_kyc_verification'),
      deliveryPermission: map.parseBool('order_delivery_permission'),
      canUpdateProductStatus:
          map.parseBool('seller_product_status_update_permission'),
      kycConfig: map.converter(
        'kyc_config',
        (v) => v is List ? v.map((e) => KYCConfig.fromMap(e)).toList() : [],
      ),
      minDepositAmount: map.parseNum('seller_min_deposit_amount'),
      maxDepositAmount: map.parseNum('seller_max_deposit_amount'),
    );
  }

  final bool canUpdateProductStatus;
  final JEnum deliveryStatus;
  final bool kycVerification;
  final bool leftCurrency;
  final bool registration;
  final JEnum ticketPriority;
  final List<KYCConfig> kycConfig;
  final bool deliveryPermission;
  final num minDepositAmount;
  final num maxDepositAmount;

  List<MapEntry<String, int>> get validStatus {
    final vList = [2, 3];
    if (deliveryPermission) vList.addAll([4, 5, 7]);

    return deliveryStatus.enumData.entries
        .where((e) => vList.contains(e.value))
        .toList();
  }

  Map<String, dynamic> toMap() {
    final data = {
      'registration': registration,
      'delevary_status': deliveryStatus.enumData,
      'ticket_priority': ticketPriority.enumData,
      'currency_position_is_left': leftCurrency,
      'seller_kyc_verification': kycVerification,
      'seller_product_status_update_permission': canUpdateProductStatus,
      'kyc_config': kycConfig.map((e) => e.toMap()).toList(),
      'order_delivery_permission': deliveryPermission,
      'seller_min_deposit_amount': minDepositAmount,
      'seller_max_deposit_amount': maxDepositAmount,
    };
    return data;
  }
}
