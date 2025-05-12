import 'dart:io';

import 'package:dio/dio.dart';
import 'package:seller_management/features/kyc/repository/kyc_repo.dart';
import 'package:seller_management/main.export.dart';

final kycLogsProvider = FutureProvider.autoDispose<List<KYCLog>>((ref) async {
  final repo = locate<KycRepo>();

  final data = await repo.kycLogs();

  return data.fold((l) => l.toFError(), (r) => r.data);
});

final kycCtrlProvider =
    AutoDisposeNotifierProvider<KYCCtrlNotifier, KYCLog?>(KYCCtrlNotifier.new);

class KYCCtrlNotifier extends AutoDisposeNotifier<KYCLog?> {
  final _repo = locate<KycRepo>();

  @override
  KYCLog? build() {
    return null;
  }

  Future<KYCLog?> submitKYC(QMap data, Map<String, File> files) async {
    final formData = <String, dynamic>{
      'kyc_data': {...data, 'files': {}}
    };

    for (var entry in files.entries) {
      formData['kyc_data']['files'][entry.key] =
          await MultipartFile.fromFile(entry.value.path);
    }

    final res = await _repo.submitKYC(formData);

    state = res.fold(
      (l) {
        Toaster.showError(l);
        return null;
      },
      (r) => r.data,
    );

    return state;
  }
}
