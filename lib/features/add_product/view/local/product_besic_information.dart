import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/features/add_product/controller/add_product_ctrl.dart';
import 'package:seller_management/features/add_product/view/local/local.dart';
import 'package:seller_management/main.export.dart';

class ProductBasicInformation extends HookConsumerWidget {
  const ProductBasicInformation({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(physicalStoreCtrlProvider(editingProduct));

    return ShadowContainer(
      padding: Insets.padAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TR.of(context).product_basic_info,
            style: context.textTheme.titleLarge,
          ),
          const Gap(Insets.med),
          const Divider(),
          const Gap(Insets.med),

          //!
          Text(
            TR.of(context).product_title,
            style: context.textTheme.bodyLarge!.bold,
          ).markAsRequired(),
          const Gap(Insets.sm),

          FormBuilderTextField(
            initialValue: productState.name,
            name: 'name',
            decoration: InputDecoration(
              hintText: TR.of(context).enter_product_title,
            ),
            validator: FormBuilderValidators.required(),
          ),
          const Gap(Insets.med),

          //!!
          Text(
            'Slug',
            style: context.textTheme.bodyLarge!.bold,
          ).markAsRequired(),
          const Gap(Insets.sm),

          FormBuilderTextField(
            name: 'slug',
            initialValue: productState.slug,
            decoration: const InputDecoration(
              hintText: 'Slug',
            ),
            validator: FormBuilderValidators.required(),
          ),

          const Gap(Insets.med),
          SectorButton(
            title: TR.of(context).add_basic_info,
            onEditSheetWidget: BasicProductInfoSheet(
              editingProduct: editingProduct,
            ),
            isComplete: productState.isBasicInfoDone(),
          ),
        ],
      ),
    );
  }
}
