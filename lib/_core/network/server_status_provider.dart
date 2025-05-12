import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';

import '../../routes/routes.dart';

final serverStatusProvider =
    AutoDisposeNotifierProvider<ServerStatusNotifier, ServerStatus>(
        ServerStatusNotifier.new);

class ServerStatusNotifier extends AutoDisposeNotifier<ServerStatus> {
  void update(int? code) {
    if (code == null) return;

    final status = ServerStatus.fromCode(code);
    if (status == state) return;

    state = status;
  }

  Future<void> retryStatusResolver() async {
    await ref.read(settingsCtrlProvider.notifier).reload();
  }

  @override
  ServerStatus build() {
    ServerStatus status = ServerStatus.active;

    return status;
  }
}

enum ServerStatus {
  active,
  maintenance,
  invalidPurchase,
  panelNotActive,
  noKYC;

  RouteName? get paths => switch (this) {
        ServerStatus.active => null,
        ServerStatus.maintenance => RouteNames.maintenance,
        ServerStatus.invalidPurchase => RouteNames.invalidPurchase,
        ServerStatus.panelNotActive => RouteNames.panelNotActive,
        ServerStatus.noKYC => RouteNames.verifyKyc,
      };
  int? get code => switch (this) {
        active => null,
        maintenance => 1000000,
        invalidPurchase => 2000000,
        panelNotActive => 3000000,
        noKYC => 6000000,
      };

  factory ServerStatus.fromCode(int? code) => switch (code) {
        1000000 => ServerStatus.maintenance,
        2000000 => ServerStatus.invalidPurchase,
        3000000 => ServerStatus.panelNotActive,
        6000000 => ServerStatus.noKYC,
        _ => ServerStatus.active,
      };

  bool get isActive => this == ServerStatus.active;
  bool get isMaintenance => this == ServerStatus.maintenance;
  bool get isNoKYC => this == ServerStatus.noKYC;
  bool get isInvalidPurchase => this == ServerStatus.invalidPurchase;
  bool get isPanelNotActive => this == ServerStatus.panelNotActive;
}
