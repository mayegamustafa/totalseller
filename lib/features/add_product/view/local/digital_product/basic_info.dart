import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/features/add_product/controller/add_digital_ctrl.dart';
import 'package:seller_management/main.export.dart';

class BasicInformation extends HookConsumerWidget {
  const BasicInformation({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(digitalStoreCtrlProvider(editingProduct));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TR.of(context).product_basic_info,
          style: context.textTheme.titleLarge,
        ),
        const Gap(Insets.med),
        ShadowContainer(
          child: Padding(
            padding: Insets.padAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TR.of(context).product_title,
                  style: context.textTheme.bodyLarge!.bold,
                ).markAsRequired(),
                const Gap(Insets.sm),

                //!!
                FormBuilderTextField(
                  name: 'name',
                  initialValue: productState.name,
                  decoration: InputDecoration(
                    hintText: TR.of(context).enter_product_title,
                  ),
                  validator: FormBuilderValidators.required(),
                ),

                const Gap(Insets.med),
                Text(
                  'Slug',
                  style: context.textTheme.bodyLarge!.bold,
                ).markAsRequired(),
                const Gap(Insets.sm),

                //!!
                FormBuilderTextField(
                  name: 'slug',
                  initialValue: productState.slug,
                  decoration: const InputDecoration(
                    hintText: 'Slug',
                  ),
                  validator: FormBuilderValidators.required(),
                ),
                const Gap(Insets.med),

                Text(
                  'Point',
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(Insets.sm),
                FormBuilderTextField(
                  name: 'point',
                  initialValue: '${productState.point ?? 0}',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Point',
                  ),
                ),
                const Gap(Insets.med),
                Text(
                  TR.of(context).product_description,
                  style: context.textTheme.bodyLarge!.bold,
                ).markAsRequired(),
                const Gap(Insets.sm),

                //!
                HtmlEditorView(
                  name: 'description',
                  hint: TR.of(context).enter_product_description,
                  initialValue: productState.description,
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
