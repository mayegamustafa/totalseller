import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:seller_management/features/add_product/controller/add_digital_ctrl.dart';
import 'package:seller_management/features/settings/controller/auth_config_ctrl.dart';
import 'package:seller_management/main.export.dart';

class CategoriesSelectionView extends HookConsumerWidget {
  const CategoriesSelectionView({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories =
        ref.watch(localAuthConfigProvider.select((v) => v?.categories));

    final productState = ref.watch(digitalStoreCtrlProvider(editingProduct));
    final productCtrl = useCallback(
        () => ref.read(digitalStoreCtrlProvider(editingProduct).notifier));

    final subCategories = categories
        ?.firstWhereOrNull((c) => c.id == productState.categoryId?.asInt)
        ?.subCategory
        .toList();

    return ShadowContainer(
      padding: Insets.padAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TR.of(context).product_categories,
            style: context.textTheme.titleLarge,
          ),
          const Gap(Insets.med),
          if (categories != null && categories.isNotEmpty)
            DropDownField<int>(
              headerText: TR.of(context).categories,
              itemCount: categories.length,
              value: productState.categoryId?.asInt,
              hintText: TR.of(context).select_item,
              onChanged: (v) {
                productCtrl().setSubCategory(null);
                productCtrl().setCategory(v.toString());
              },
              itemBuilder: (context, index) {
                final category = categories[index];
                return DropdownMenuItem(
                  value: category.id,
                  child: Text(category.name.toTitleCase),
                );
              },
              isRequired: true,
            )
          else
            WarningBox(
              TR.of(context).no_categories_found,
            ),
          const Gap(Insets.lg),
          Text(
            TR.of(context).sub_categories,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(Insets.sm),
          if (subCategories.isNotNullOrEmpty())
            DropDownField<int>(
              itemCount: subCategories?.length,
              value: productState.subCategoryId?.asInt,
              hintText: TR.of(context).select_item,
              onChanged: (v) {
                productCtrl().setSubCategory(v.toString());
              },
              itemBuilder: (context, index) {
                final subCategory = subCategories?[index];
                return DropdownMenuItem(
                  value: subCategory?.id ?? -1,
                  child: Text(subCategory?.name.toTitleCase ?? ''),
                );
              },
            )
          else
            WarningBox(
              subCategories == null
                  ? TR.of(context).add_a_categories_first
                  : TR.of(context).no_sub_categories_found,
              type: WarningBoxType.info,
            ),
        ],
      ),
    );
  }
}
