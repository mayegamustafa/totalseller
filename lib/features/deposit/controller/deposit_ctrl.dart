import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seller_management/features/deposit/repository/deposit_repo.dart';
import 'package:seller_management/main.export.dart';

final depositLogsCtrlProvider = AutoDisposeAsyncNotifierProvider<
    DepositLogsCtrlNotifier,
    PagedItem<DepositLog>>(DepositLogsCtrlNotifier.new);

class DepositLogsCtrlNotifier
    extends AutoDisposeAsyncNotifier<PagedItem<DepositLog>> {
  final _repo = locate<DepositRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> search(String trx) async {
    final data = await _repo.getDepositLog(trx: trx);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> searchWithDateRange(DateTimeRange? range) async {
    if (range == null) return;
    final date =
        '${range.start.formatDate('yyyy-MM-dd')}+to+${range.end.formatDate('yyyy-MM-dd')}';

    final data = await _repo.getDepositLog(date: date);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> listByUrl(String? url) async {
    if (url == null) return;
    state = const AsyncValue.loading();
    final data = await _repo.fromUrl(url);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  @override
  FutureOr<PagedItem<DepositLog>> build() async {
    final data = await _repo.getDepositLog();
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}

final depositCtrlProvider =
    AutoDisposeNotifierProvider<DepositCtrlNotifier, PaymentMethod?>(
        DepositCtrlNotifier.new);

class DepositCtrlNotifier extends AutoDisposeNotifier<PaymentMethod?> {
  Future<DepositLog?> makeDeposit(QMap formData) async {
    if (state == null) {
      return Toaster.showError('Please select payment method').andReturn(null);
    }

    formData['payment_id'] = state?.id;

    final data = await _repo.makeDeposit(formData);

    final deposit = data.fold(
      (l) => Toaster.showError(l).andReturn(null),
      (r) {
        if (r.data.msg != null) Toaster.showSuccess(r.data.msg);
        ref.invalidate(depositLogsCtrlProvider);
        // state = null;
        return r.data.data;
      },
    );
    return deposit;
  }

  void setMethod(PaymentMethod? method) {
    if (method == state) return state = null;
    state = method;
  }

  @override
  PaymentMethod? build() {
    return null;
  }

  final _repo = locate<DepositRepo>();
}
