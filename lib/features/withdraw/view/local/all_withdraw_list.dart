import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';

import '../../controller/withdraw_ctrl.dart';

class AllWithdrawTable extends StatelessWidget {
  const AllWithdrawTable({
    super.key,
    required this.searchCtrl,
    required this.withdrawCtrl,
    required this.withdrawList,
  });

  final TextEditingController searchCtrl;
  final WithdrawListCtrlNotifier Function() withdrawCtrl;
  final AsyncValue<PagedItem<WithdrawData>> withdrawList;

  @override
  Widget build(BuildContext context) {
    final tStyle = context.onTab
        ? context.textTheme.bodyLarge
        : context.textTheme.labelMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Insets.padH,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              TR.of(context).all_withdraw,
              style: context.textTheme.titleLarge,
            ),
          ),
        ),
        const Gap(Insets.lg),
        Padding(
          padding: Insets.padH,
          child: TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  searchCtrl.clear();
                  withdrawCtrl().reload();
                },
                icon: const Icon(Icons.clear),
              ),
              hintText: TR.of(context).search_by_trx_id,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) => withdrawCtrl().search(value),
          ),
        ),
        const Gap(Insets.sm),
        const Padding(
          padding: Insets.padH,
          child: KTableHeader(),
        ),
        const Gap(Insets.sm),
        withdrawList.when(
          loading: Loader.list,
          error: ErrorView.new,
          data: (data) => ListViewWithFooter(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            pagination: data.pagination,
            onNext: (url) => withdrawCtrl().listByUrl(url),
            onPrevious: (url) => withdrawCtrl().listByUrl(url),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ExpansionTable(
                  readableTime: item.readableTime,
                  date: item.date,
                  trx: item.trxNo,
                  receivable: item.finalAmount.formate(
                    currency: item.currency,
                  ),
                  builder: (context) {
                    return {
                      Text(
                        '${TR.of(context).method}:',
                        style: tStyle?.bold,
                      ): Text(
                        item.method.name,
                        style: tStyle,
                      ),
                      Text(
                        '${TR.of(context).amount}:',
                        style: tStyle?.bold,
                      ): Text(
                        item.amount.formate(useBase: true),
                        style: tStyle?.textColor(
                          context.colors.errorContainer,
                        ),
                      ),
                      Text(
                        '${TR.of(context).charge}:',
                        style: tStyle?.bold,
                      ): Text(
                        item.charge.formate(useBase: true),
                        style: tStyle?.textColor(
                          context.colors.error,
                        ),
                      ),
                      Text(
                        '${TR.of(context).status}:',
                        style: tStyle?.bold,
                      ): Container(
                        decoration: BoxDecoration(
                          color: item.statusColor.withOpacity(.1),
                          borderRadius: Corners.smBorder,
                        ),
                        padding: Insets.padSym(5, 10),
                        child: Text(
                          item.status,
                          style: tStyle?.textColor(item.statusColor),
                        ),
                      ),
                      if (item.feedback.isNotEmpty)
                        Text(
                          '${TR.of(context).note}:',
                          style: tStyle?.bold,
                        ): Text(
                          item.feedback,
                          style: tStyle?.textColor(context.colors.error),
                        )
                    };
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
