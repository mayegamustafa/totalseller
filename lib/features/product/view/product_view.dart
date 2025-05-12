import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:seller_management/features/product/view/digital_product_list.dart';
import 'package:seller_management/features/product/view/in_house_product_list.dart';
import 'package:seller_management/features/seller_info/controller/seller_info_ctrl.dart';
import 'package:seller_management/features/settings/controller/auth_config_ctrl.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/page/no_sub.dart';
import 'package:seller_management/routes/routes.dart';

import '../../dashboard/view/local/local.dart';

class ProductView extends HookConsumerWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(
        0.ms,
        () {
          ref.read(sellerCtrlProvider.notifier).reload();
          ref.read(authConfigCtrlProvider.notifier).reload();
        },
      );
      return null;
    }, const []);

    final subsRunning = ref.watch(localAuthConfigProvider
        .select((value) => value?.runningSubscription ?? false));

    final sellerData = ref.watch(sellerCtrlProvider);

    final tab = context.queryParams.parseInt('tab');

    final tabController = useTabController(
      initialLength: 2,
      initialIndex: tab,
      keys: [tab],
    );

    return sellerData.when(
      error: (error, stackTrace) => ErrorRoutePage(error: error),
      loading: () => Scaffold(
        appBar: AppBar(
          title: Text(
            TR.of(context).manage_product,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Loader.grid(),
        ),
      ),
      data: (seller) {
        if (!seller.shop.isShopActive) {
          return const NotActiveStore();
        }
        if (!subsRunning) return const NoSubPage();

        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: Get.context!,
                    isScrollControlled: true,
                    builder: (context) {
                      return const ProductAddSheet();
                    },
                  );
                },
                child: Text(
                  '+ ${TR.of(context).add_product}',
                ),
              ),
              const Gap(Insets.med)
            ],
            title: Text(
              TR.of(context).manage_product,
            ),
            bottom: TabBar(
              controller: tabController,
              labelColor: context.colors.onSurface,
              unselectedLabelColor: context.colors.onSurface.withOpacity(.6),
              dividerColor: context.colors.onSecondaryContainer,
              indicatorColor: context.colors.onSurface,
              tabs: [
                Tab(text: TR.of(context).in_house_product),
                Tab(text: TR.of(context).digital_product),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: const [
              InHouseProductList(),
              DigitalProductList(),
            ],
          ),
        );
      },
    );
  }
}
