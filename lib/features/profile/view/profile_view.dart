import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seller_management/features/auth/controller/auth_ctrl.dart';
import 'package:seller_management/features/dashboard/view/local/local.dart';
import 'package:seller_management/features/seller_info/controller/seller_info_ctrl.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/routes.dart';

import 'local/profile_button.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellerData = ref.watch(sellerCtrlProvider);
    final gap = context.onMobile ? Insets.lg : Insets.xl;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(TR.of(context).profile),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         ref.read(themeModeProvider.notifier).toggleTheme();
      //       },
      //       icon: Icon(context.isDark ? Icons.light_mode : Icons.dark_mode),
      //     ),
      //   ],
      // ),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(sellerCtrlProvider.notifier).reload(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              sellerData.when(
                loading: () => Loader.shimmer(200, context.width),
                error: ErrorView.new,
                data: (seller) => ShadowContainer(
                  child: Padding(
                    padding: Insets.padAll,
                    child: Column(
                      children: [
                        const SizedBox(width: double.infinity),
                        const Gap(30),
                        Stack(
                          children: [
                            CircleImage(
                              seller.image,
                              radius: 60,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => RouteNames.accountSettings
                                    .pushNamed(context),
                                child: CircleAvatar(
                                  backgroundColor: context.colors.primary,
                                  child: SvgPicture.asset(
                                    AssetsConst.edit,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      context.colors.onPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Gap(Insets.med),
                        Text(
                          seller.name.ifEmpty('N/A'),
                          style: context.textTheme.titleLarge,
                        ),
                        Text(
                          seller.phone.ifEmpty('N/A'),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(Insets.lg),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: Insets.padH,
                child: Column(
                  children: [
                    const Gap(Insets.lg),
                    ShadowContainer(
                      child: Padding(
                        padding: Insets.padAll,
                        child: Column(
                          children: [
                            ProfileButton(
                              title: TR.of(context).seller_profile,
                              onTap: () =>
                                  RouteNames.accountSettings.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).store_info,
                              onTap: () => RouteNames.storeInformation
                                  .pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).withdraw,
                              onTap: () =>
                                  RouteNames.withdraw.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: 'Deposit',
                              onTap: () =>
                                  RouteNames.deposit.pushNamed(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(Insets.lg),
                    ShadowContainer(
                      child: Padding(
                        padding: Insets.padAll,
                        child: Column(
                          children: [
                            ProfileButton(
                              title: TR.of(context).add_product,
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
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).subscription_plan,
                              onTap: () =>
                                  RouteNames.subscription.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).all_product,
                              onTap: () =>
                                  RouteNames.product.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).order,
                              onTap: () => RouteNames.order.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).account_settlement,
                              onTap: () =>
                                  RouteNames.totalBalance.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).ticket,
                              onTap: () =>
                                  RouteNames.messages.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).language,
                              onTap: () =>
                                  RouteNames.language.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: TR.of(context).currency,
                              onTap: () =>
                                  RouteNames.currency.pushNamed(context),
                            ),
                            Gap(gap),
                            ProfileButton(
                              title: 'KYC Logs',
                              onTap: () =>
                                  RouteNames.kycLogs.pushNamed(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(Insets.lg),
                    ShadowContainer(
                      child: Padding(
                        padding: Insets.padAll,
                        child: Column(
                          children: [
                            ProfileButton(
                              title: TR.of(context).change_password,
                              onTap: () =>
                                  RouteNames.updatePass.pushNamed(context),
                            ),
                            Gap(context.onMobile ? Insets.lg : Insets.xl),
                            ProfileButton(
                              title: TR.of(context).logout,
                              onTap: () {
                                ref.read(authCtrlProvider.notifier).logout();
                              },
                            ),
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
    );
  }
}
