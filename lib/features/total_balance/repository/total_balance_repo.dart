import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

class TransactionRepo extends Repo {
  FutureReport<BaseResponse<PagedItem<TransactionData>>> transactionList({
    DateTimeRange? dateRange,
    String search = '',
  }) async {
    final data =
        await rdb.getTransactionList(date: dateRange.toQuery(), search: search);
    return data;
  }

  FutureReport<BaseResponse<PagedItem<TransactionData>>> transactionListFromUrl(
      String url) async {
    final data = await rdb.transactionsFromUrl(url);
    return data;
  }
}
