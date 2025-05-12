import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/features/add_product/controller/add_product_ctrl.dart';
import 'package:seller_management/features/settings/controller/auth_config_ctrl.dart';
import 'package:seller_management/main.export.dart';

class ProductBrandSheet extends HookConsumerWidget {
  const ProductBrandSheet({
    super.key,
    required this.editingProduct,
  });
  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(localAuthConfigProvider.select((v) => v?.brands));
    final productState = ref.watch(physicalStoreCtrlProvider(editingProduct));

    final productCtrl = useCallback(
        () => ref.read(physicalStoreCtrlProvider(editingProduct).notifier));

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: context.height / 2,
        child: ShadowContainer(
          child: Padding(
            padding: Insets.padAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TR.of(context).product_brand,
                  style: context.textTheme.titleLarge,
                ),
                const Gap(Insets.med),
                const Divider(),
                const Gap(Insets.med),
                Text(
                  TR.of(context).brand,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(Insets.sm),
                //!
                if (brands != null && brands.isNotEmpty)
                  FormBuilderDropField<int>(
                    name: 'brand_id',
                    itemCount: brands.length,
                    initialValue: productState.brandId?.asInt,
                    hintText: TR.of(context).select_item,
                    onChanged: (v) {
                      productCtrl().setBrand(v.toString());
                    },
                    itemBuilder: (context, index) {
                      final brand = brands[index];
                      return DropdownMenuItem(
                        value: brand.id,
                        child: Text(brand.name.toTitleCase),
                      );
                    },
                  )
                else
                  WarningBox(TR.of(context).no_brand_found),

                const Gap(Insets.offset),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          productCtrl().setBrand(null);
                          context.pop();
                        },
                        child: Text(
                          TR.of(context).clear,
                        ),
                      ),
                    ),
                    const Gap(Insets.def),
                    Expanded(
                      child: SubmitButton.dense(
                        onPressed: (l) => context.pop(),
                        child: Text(
                          TR.of(context).submit,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
