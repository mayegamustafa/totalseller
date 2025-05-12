import 'package:seller_management/main.export.dart';

class DepositRepo extends Repo {
  FutureResponse<PagedItem<DepositLog>> getDepositLog({
    String trx = '',
    String date = '',
  }) async {
    return await rdb.getDepositLogs(trx, date);
  }

  FutureResponse<PagedItem<DepositLog>> fromUrl(String url) async {
    return await rdb.pagedItemFromUrl(
      url,
      'deposit_logs',
      (v) => DepositLog.fromMap(v),
    );
  }

  FutureResponse<PostMeg<DepositLog>> makeDeposit(QMap form) async {
    return await rdb.makeDeposit(form);
  }
}
