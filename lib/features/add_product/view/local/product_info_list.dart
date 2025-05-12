import 'package:flutter/material.dart';
import 'package:seller_management/features/add_product/controller/add_product_ctrl.dart';
import 'package:seller_management/main.export.dart';

import 'local.dart';
import 'sheets/tax_config_sheet.dart';

class ProductInfoList extends HookConsumerWidget {
  const ProductInfoList({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(physicalStoreCtrlProvider(editingProduct));

    return Column(
      children: [
        SectorButton(
          title: TR.of(context).product_attribute,
          isComplete: productState.isAttributeValid(),
          onEditSheetWidget: ProductAttributeSheet(
            editingProduct: editingProduct,
          ),
        ),
        const Gap(Insets.lg),
        SectorButton(
          title: TR.of(context).product_categories,
          isComplete: productState.isCategoryDone(),
          onEditSheetWidget: ProductCategoriesSheet(
            editingProduct: editingProduct,
          ),
        ),
        const Gap(Insets.lg),
        SectorButton(
          title: TR.of(context).product_brand,
          isComplete: productState.brandId != null,
          onEditSheetWidget: ProductBrandSheet(
            editingProduct: editingProduct,
          ),
        ),
        const Gap(Insets.lg),
        SectorButton(
          isComplete: productState.shippingDeliveryIds.isNotNullOrEmpty(),
          title: TR.of(context).product_shipping,
          onEditSheetWidget: ProductShippingSheet(
            editingProduct: editingProduct,
          ),
        ),
        const Gap(Insets.lg),
        SectorButton(
          isComplete: productState.isTaxDataDone(),
          title: 'Tax Configuration',
          onEditSheetWidget: TaxConfigSheet(
            editingProduct: editingProduct,
          ),
        ),
        const Gap(Insets.lg),
        SectorButton(
          title: TR.of(context).product_warranty_policy,
          isComplete: productState.warrantyPolicy.isNotNullOrEmpty(),
          onEditSheetWidget: ProductWarrantyPolicySheet(
            editingProduct: editingProduct,
          ),
        ),
        const Gap(Insets.lg),
        SectorButton(
          title: TR.of(context).meta_data,
          isComplete: productState.isMetaDataDone(),
          onEditSheetWidget: ProductMetaSheet(
            editingProduct: editingProduct,
          ),
        ),
      ],
    );
  }
}
