import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:seller_management/features/dashboard/controller/dash_ctrl.dart';
import 'package:seller_management/features/deposit/controller/deposit_ctrl.dart';
import 'package:seller_management/features/deposit/view/local/deposit_appbar.dart';
import 'package:seller_management/features/deposit/view/local/deposit_log_view.dart';
import 'package:seller_management/main.export.dart';

class DepositView extends HookConsumerWidget {
  const DepositView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashBoard = ref.watch(dashBoardCtrlProvider);

    final depositCtrl =
        useCallback(() => ref.read(depositLogsCtrlProvider.notifier));

    final searchCtrl = useTextEditingController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 200),
        child: DepositAppbar(dashBoard: dashBoard),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return depositCtrl().reload();
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: Insets.padAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deposit history',
                  style: context.textTheme.titleLarge,
                ),
                const Gap(Insets.med),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: searchCtrl,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: () {
                              searchCtrl.clear();
                              depositCtrl().reload();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          hintText: TR.of(context).search_by_trx_id,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) => depositCtrl().search(value),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () async {
                        final range = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now().add(30.days),
                        );
                        depositCtrl().searchWithDateRange(range);
                      },
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                  ],
                ),
                const Gap(Insets.med),
                const DepositLogView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
