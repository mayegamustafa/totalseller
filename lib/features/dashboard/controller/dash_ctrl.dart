import 'dart:async';

import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';

import '../repository/dash_repo.dart';

final dashBoardCtrlProvider =
    AutoDisposeAsyncNotifierProvider<DashBoardCtrlNotifier, Dashboard>(
        DashBoardCtrlNotifier.new);

class DashBoardCtrlNotifier extends AutoDisposeAsyncNotifier<Dashboard> {
  final _repo = locate<DashboardRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
    ref.invalidate(settingsCtrlProvider);
  }

  @override
  FutureOr<Dashboard> build() async {
    final data = await _repo.getDashboard();
    return data.fold(
      (l) => l.toFError(),
      (r) {
        ref.read(localDashProvider.notifier).save(r.data);
        return r.data;
      },
    );
  }
}

final localDashProvider =
    AutoDisposeNotifierProvider<_LocalDashBoardCtrlNotifier, Dashboard?>(
        _LocalDashBoardCtrlNotifier.new);

class _LocalDashBoardCtrlNotifier extends AutoDisposeNotifier<Dashboard?> {
  @override
  Dashboard? build() {
    return locate<DashboardRepo>().getDashSync();
  }

  Future<void> save(Dashboard dash) async {
    await locate<DashboardRepo>().saveDash(dash);
    ref.invalidateSelf();
  }
}
