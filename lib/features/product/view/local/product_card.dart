import 'package:flutter/material.dart';
import 'package:seller_management/features/product/controller/product_ctrl.dart';
import 'package:seller_management/features/product/view/local/phy_edit_stock_sheet.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';
import 'package:seller_management/routes/go_route_config.dart';
import 'package:seller_management/routes/go_route_name.dart';
import 'package:share_plus/share_plus.dart';

import 'product_status_update_sheet.dart';

class ProductCard extends HookConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.permanentDelete,
  });

  final ProductModel product;
  final bool permanentDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCtrl = useCallback(
      () => ref.read(productDetailsCtrlProvider(product.uid).notifier),
    );

    final canUpdateStatus = ref.watch(
        localSettingsProvider.select((s) => s?.config.canUpdateProductStatus));
    return GestureDetector(
      onTap: permanentDelete
          ? null
          : () => RouteNames.productDetails
              .pushNamed(context, pathParams: {'id': product.uid}),
      child: Stack(
        children: [
          ShadowContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Corners.medRadius,
                  ),
                  child: Center(
                    child: HostedImage(
                      height: 130,
                      width: double.infinity,
                      product.featuredImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: Insets.padAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(Insets.med),
                      Text(
                        product.name,
                        maxLines: 1,
                        style: context.textTheme.bodyLarge,
                      ),
                      const Gap(Insets.sm),
                      Text(
                        product.price.formate(),
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(Insets.sm),
                      if (product.stock.isNotEmpty)
                        Text(
                          '${TR.of(context).stock}: ${product.stock.first.qty}',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: context.colors.errorContainer,
                          ),
                        ),
                      if (product.stock.isEmpty)
                        Text(
                          TR.of(context).out_of_stock,
                          style: TextStyle(color: context.colors.error),
                        ),
                      const Gap(Insets.med),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (canUpdateStatus == true && !permanentDelete)
                            GestureDetector(
                              onTap: () {
                                if (product.stock.isNotEmpty) {
                                  showModalBottomSheet(
                                    showDragHandle: true,
                                    context: Get.context!,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: PhysicalStockBottomSheet(
                                          product: product,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  Toaster.showInfo(
                                    TR.of(context).this_product_out_of_stock,
                                  );
                                }
                              },
                              child: Text(
                                TR.of(context).edit_stock,
                                style: TextStyle(
                                  color: context.colors.primary,
                                ),
                              ),
                            ),
                          const Spacer(),
                          const Gap(Insets.sm),
                          if (canUpdateStatus == true && !permanentDelete)
                            if (product.canUpdateStatus)
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    showDragHandle: true,
                                    context: Get.context!,
                                    builder: (context) {
                                      return ProductStatusUpdateSheet(
                                        product: product,
                                      );
                                    },
                                  );
                                },
                                child: Tooltip(
                                  message: 'Edit Status',
                                  child: CircleAvatar(
                                    backgroundColor:
                                        context.colors.primary.withOpacity(.1),
                                    radius: 15,
                                    child: Icon(
                                      Icons.edit_rounded,
                                      size: 18,
                                      color: context.colors.primary,
                                    ),
                                  ),
                                ),
                              ),
                          const Gap(Insets.sm),
                          if (permanentDelete)
                            GestureDetector(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => DeleteAlert(
                                    title: TR.of(context).restore_this_product,
                                    buttonText: TR.of(context).restore,
                                    onDelete: () async {
                                      await productCtrl().restore();
                                      if (context.mounted) context.nPop();
                                    },
                                  ),
                                );
                              },
                              child: Tooltip(
                                message: 'Restore',
                                child: CircleAvatar(
                                  backgroundColor: context.colors.errorContainer
                                      .withOpacity(.1),
                                  radius: 15,
                                  child: Icon(
                                    Icons.restore_rounded,
                                    size: 18,
                                    color: context.colors.errorContainer,
                                  ),
                                ),
                              ),
                            ),
                          const Gap(Insets.sm),
                          GestureDetector(
                            onTap: () async {
                              if (permanentDelete) {
                                return await showDialog(
                                  context: context,
                                  builder: (context) => DeleteAlert(
                                    title: TR
                                        .of(context)
                                        .you_are_permanently_deleting_product,
                                    onDelete: () async {
                                      await productCtrl().deletePermanently();
                                      if (context.mounted) context.nPop();
                                    },
                                  ),
                                );
                              }
                              return await showDialog(
                                context: context,
                                builder: (context) => DeleteAlert(
                                  title: TR
                                      .of(context)
                                      .really_want_to_delete_this_product,
                                  onDelete: () async {
                                    await productCtrl().delete();
                                    if (context.mounted) context.nPop();
                                  },
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  context.colors.error.withOpacity(.1),
                              radius: 15,
                              child: Icon(
                                permanentDelete
                                    ? Icons.delete_forever_rounded
                                    : Icons.delete_rounded,
                                size: 18,
                                color: context.colors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (!permanentDelete)
            Positioned(
              top: 5,
              right: 5,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => RouteNames.addProduct
                        .pushNamed(context, extra: product),
                    child: CircleAvatar(
                      backgroundColor: context.colors.primary,
                      radius: 15,
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: context.colors.surfaceTint,
                      ),
                    ),
                  ),
                  const Gap(Insets.sm),
                  if (product.url.isNotEmpty)
                    GestureDetector(
                      onTap: () => Share.shareUri(Uri.parse(product.url)),
                      child: CircleAvatar(
                        backgroundColor: context.colors.primary,
                        radius: 15,
                        child: Icon(
                          Icons.share,
                          size: 18,
                          color: context.colors.onPrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Corners.medRadius,
                  bottomRight: Corners.medRadius,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(
                  product.status,
                  style: TextStyle(
                    color: context.colors.surfaceTint,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
