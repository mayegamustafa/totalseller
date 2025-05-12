import 'package:flutter/material.dart';
import 'package:seller_management/features/order/controller/order_ctrl.dart';
import 'package:seller_management/main.export.dart';

import 'local/physical_order_tab.dart';

class OrderView extends HookConsumerWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initTab = context.queryParams.parseInt('tab');
    final subTab = context.queryParams.parseInt('sub');
    final tabController =
        useTabController(initialLength: 2, initialIndex: initTab);

    final orderCtrl = useCallback(
      () => ref.read(physicalOrderCtrlProvider('').notifier),
    );
    final digitalCtrl = useCallback(
      () => ref.read(digitalOrderCtrlProvider.notifier),
    );
    final searchCtrl = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TR.of(context).manage_order,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40 + kToolbarHeight),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: searchCtrl,
                  decoration: InputDecoration(
                    hintText: TR.of(context).search_via_order_id_customer_name,
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchCtrl.clear();
                        if (tabController.index == 0) {
                          digitalCtrl().reload();
                        } else {
                          orderCtrl().reload();
                        }
                      },
                      icon: const Icon(Icons.clear_rounded),
                    ),
                  ),
                  onChanged: (value) {
                    if (tabController.index == 0) {
                      orderCtrl().search(value);
                    } else {
                      digitalCtrl().search(value);
                    }
                  },
                ),
              ),
              TabBar(
                controller: tabController,
                labelColor: context.colors.onSurface,
                unselectedLabelColor: context.colors.onSurface.withOpacity(.6),
                dividerColor: context.colors.onSecondaryContainer,
                indicatorColor: context.colors.onSurface,
                tabs: [
                  Tab(text: TR.of(context).physical_order),
                  Tab(text: TR.of(context).digital_order),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          PhysicalOrderTab(tabIndex: subTab),
          const OrderListView(tab: 'digital'),
        ],
      ),
    );
  }
}
