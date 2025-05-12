import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_config.dart';
import 'package:seller_management/routes/go_route_name.dart';
import 'package:share_plus/share_plus.dart';

import '../../../_widgets/chart/pie_chart_design.dart';
import '../../campaign/controller/campaign_ctrl.dart';
import '../controller/dash_ctrl.dart';
import 'drawer/home_drawer.dart';
import 'home_init_page.dart';
import 'local/local.dart';

class DashBoardView extends HookConsumerWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashData = ref.watch(dashBoardCtrlProvider);
    final currentIndex = useState(0);
    final campaignList = ref.watch(campaignCtrlProvider);
    return dashData.when(
      loading: () => const Scaffold(body: DashLoader()),
      error: (e, s) => Scaffold(body: ErrorView(e, s)),
      data: (dash) {
        return DashInitPage(
          child: Scaffold(
            drawer: const HomeDrawer(),
            appBar: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  icon: CircleImage(
                    dash.seller.shop.shopLogo.url,
                    radius: 20,
                    useBorder: false,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              title: Text(
                TR.of(context).seller_center,
                style: TextStyle(
                  color: context.colors.primary,
                ),
              ),
              actions: [
                if (dash.seller.shop.url.isNotEmpty)
                  IconButton.outlined(
                    onPressed: () => Share.shareUri(
                      Uri.parse(dash.seller.shop.url),
                    ),
                    icon: Icon(
                      Icons.share,
                      color: context.colors.primary,
                    ),
                  ),
                const Gap(Insets.med),
                IconButton.outlined(
                  onPressed: () {
                    ref.read(themeModeProvider.notifier).toggleTheme();
                  },
                  icon: Icon(
                    context.isDark ? Icons.light_mode : Icons.dark_mode,
                    color: context.colors.primary,
                  ),
                ),
                const Gap(Insets.med)
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async =>
                  ref.read(dashBoardCtrlProvider.notifier).reload(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: Insets.padH,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(Insets.xl),
                          if (context.onMobile)
                            DashTopButton(dash: dash)
                          else
                            DashTopAllCartTabView(dash: dash),
                          const Gap(Insets.xl),
                          Text(
                            'Order Overview',
                            style: context.textTheme.titleLarge,
                          ),
                          const Gap(Insets.med),
                        ],
                      ),
                    ),
                    OrderOverviewSlider(overview: dash.overview),
                    Padding(
                      padding: Insets.padH,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(Insets.xl),
                          Text(
                            TR.of(context).add_product,
                            style: context.textTheme.titleLarge,
                          ),
                          const Gap(Insets.med),
                          if (dash.seller.shop.isShopActive)
                            const AddProductCard(),
                          // const ProductQuickActionCard(),
                          const Gap(Insets.xl),
                          //! pie chart
                          Text(
                            TR.of(context).monthly_order_overview,
                            style: context.textTheme.titleLarge,
                          ),
                          const Gap(Insets.lg),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: Corners.medBorder,
                              color: context.colors.onPrimaryContainer,
                            ),
                            child: PieChartDesign(
                              data: dash.graphData.monthlyOrderReport,
                            ),
                          ),
                          // PieChartWidget(
                          //   data: dash.graphData.monthlyOrderReport,
                          // ),
                          const Gap(Insets.lg),
                          //! line chart
                          Text(
                            TR.of(context).all_order_overview,
                            style: context.textTheme.titleLarge,
                          ),

                          const Gap(Insets.lg),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: Corners.medBorder,
                              color: context.colors.onPrimaryContainer,
                            ),
                            child: Padding(
                              padding: Insets.padAll,
                              child: LineChartDesign(
                                data: dash.graphData.yearlyOrderReport,
                              ),
                            ),
                          ),
                          const Gap(Insets.xl),

                          Text(
                            TR.of(context).all_transaction_log,
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(Insets.lg),

                          //! all transaction
                          AllTransactionLog(transactions: dash.transactions),
                          // TransactionLogTable(transactions: dash.transactions),

                          //! campaigns
                          if (dash.seller.shop.isShopActive)
                            campaignList.when(
                              loading: () => Loader.shimmer(160, context.width),
                              error: (e, s) => ErrorView(e, s,
                                  invalidate: campaignCtrlProvider),
                              data: (campaigns) {
                                if (campaigns.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      TR.of(context).ongoing_campaign,
                                      style: context.textTheme.titleLarge,
                                    ),
                                    const Gap(Insets.med),
                                    CarouselSlider.builder(
                                      options: CarouselOptions(
                                        onPageChanged: (index, _) =>
                                            currentIndex.value = index,
                                        enlargeFactor: 0,
                                        clipBehavior: Clip.none,
                                        viewportFraction: 1,
                                        initialPage: 0,
                                        height: context.onMobile ? 160 : 250,
                                        autoPlay: false,
                                      ),
                                      itemCount: campaignList.value!.length,
                                      itemBuilder: (context, index, realIndex) {
                                        final campaign =
                                            campaignList.value![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: GestureDetector(
                                            onTap: () => RouteNames.campaign
                                                .pushNamed(context,
                                                    extra: campaign),
                                            child: CampaignCard(
                                              campaign: campaign,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),

                          const Gap(Insets.lg),
                          DecoratedContainer(
                            child: Padding(
                              padding: Insets.padAll,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    TR.of(context).store_performance,
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(Insets.med),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        OrderStatusCard(
                                          width: 120,
                                          height: 90,
                                          count:
                                              '${dash.overview.cancelOrderRate.toStringAsFixed(2)}%',
                                          status: TR.of(context).cancel_rate,
                                        ),
                                        OrderStatusCard(
                                          width: 120,
                                          height: 90,
                                          count:
                                              '${dash.overview.deliveredOrderRate.toStringAsFixed(2)}%',
                                          status: TR.of(context).delivery_rate,
                                        ),
                                        OrderStatusCard(
                                          width: 120,
                                          height: 90,
                                          count:
                                              '${dash.overview.physicalOrderRate.toStringAsFixed(2)}%',
                                          status: TR
                                              .of(context)
                                              .physical_order_rate,
                                        ),
                                        OrderStatusCard(
                                          width: 120,
                                          height: 90,
                                          count:
                                              '${dash.overview.digitalOrderRate.toStringAsFixed(2)}%',
                                          status:
                                              TR.of(context).digital_order_rate,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddProductCard extends StatelessWidget {
  const AddProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: Corners.medBorder,
        color: Color(0xff6a5fff),
      ),
      child: Padding(
        padding: Insets.padAll.copyWith(top: 20),
        child: Row(
          children: [
            Column(
              children: [
                Lottie.asset(
                  AssetsConst.addAnimation,
                  height: 80,
                ),
                const Gap(Insets.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          context: Get.context!,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const ProductAddSheet();
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: context.colors.onPrimary,
                        ),
                        // border: Border.all(

                        // )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                TR.of(context).add_product,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    TR.of(context).add_product_title,
                    style: TextStyle(
                      fontSize: 17,
                      color: context.colors.onPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(Insets.med),
                  Lottie.asset(
                    AssetsConst.productAddAnimation,
                    height: 120,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
