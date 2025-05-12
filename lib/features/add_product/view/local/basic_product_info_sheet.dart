import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/features/add_product/controller/add_product_ctrl.dart';
import 'package:seller_management/main.export.dart';

class BasicProductInfoSheet extends HookConsumerWidget {
  const BasicProductInfoSheet({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final productState = ref.watch(physicalStoreCtrlProvider(editingProduct));
    final productCtrl = useCallback(
        () => ref.read(physicalStoreCtrlProvider(editingProduct).notifier));

    return SizedBox(
      height: context.height / 1.15,
      child: SingleChildScrollView(
        padding: Insets.padAll,
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(Insets.lg),
              ShadowContainer(
                child: Padding(
                  padding: Insets.padAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //!
                      Text(
                        TR.of(context).regular_price,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'price',
                        initialValue: productState.price,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: TR.of(context).product_price,
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      const Gap(Insets.lg),

                      //!
                      Text(
                        TR.of(context).discount_percentage,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'discount_percentage',
                        initialValue: productState.discountPercentage,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(hintText: '0'),
                        validator: (v) {
                          final val = int.tryParse(v ?? '0') ?? 0;
                          if (val.isNegative) return 'Enter Valid Number';
                          return null;
                        },
                      ),
                      const Gap(Insets.lg),

                      //!
                      Text(
                        TR.of(context).purchase_quantity_min,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'minimum_purchase_qty',
                        initialValue: productState.minQty,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: TR.of(context).min_qty_should_be,
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            (v) {
                              final val = int.tryParse(v ?? '0') ?? 0;
                              if (val < 1) {
                                return TR.of(context).min_qty_should_be;
                              }
                              return null;
                            },
                          ],
                        ),
                      ),
                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).purchase_quantity_max,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'maximum_purchase_qty',
                        initialValue: productState.maxQty,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: TR.of(context).max_qty_unlimited,
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            (v) {
                              final val = int.tryParse(v ?? '0') ?? 0;
                              if (val < 1) {
                                return 'Max Qty should be more than 1';
                              }
                              return null;
                            },
                          ],
                        ),
                      ),
                      const Gap(Insets.lg),

                      //!
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
                      //!
                      const Gap(Insets.lg),
                      Text(
                        'Weight',
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'weight',
                        initialValue: productState.weight,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Weight in kg',
                        ),
                      ),
                      //!
                      const Gap(Insets.lg),
                      Text(
                        'Shipping Fee',
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'shipping_fee',
                        initialValue: productState.shippingFee,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Flat Shipping Fee',
                        ),
                      ),
                      //!
                      const Gap(Insets.lg),
                      Text(
                        'Multiply Shipping Fee',
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(Insets.sm),
                      DropDownField<bool>(
                        hintText: 'Shipping Fee Multiplier',
                        itemCount: 2,
                        value: productState.feeMultiplier,
                        onChanged: (v) =>
                            productCtrl().setShippingFeeMultiplier(v),
                        itemBuilder: (itemContext, index) {
                          final list = [true, false];
                          final it = list[index];
                          return DropdownMenuItem(
                            value: it,
                            child: Text(
                              it
                                  ? 'Multiply Shipping Fee by quantity'
                                  : 'Do not multiply',
                            ),
                          );
                        },
                      ),
                      //!
                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).short_description,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      SizedBox(
                        height: 420,
                        child: HtmlEditorView(
                          name: 'short_description',
                          initialValue: productState.shortDescription,
                          validators: [FormBuilderValidators.required()],
                        ),
                      ),

                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).product_description,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      SizedBox(
                        height: 420,
                        child: HtmlEditorView(
                          name: 'description',
                          initialValue: productState.description,
                          validators: [FormBuilderValidators.required()],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.viewPaddingOf(context).bottom),
                    ],
                  ),
                ),
              ),
              const Gap(Insets.lg),
              Padding(
                padding: Insets.padH,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: SubmitButton(
                    onPressed: (isLoading) {
                      var state = formKey.currentState;
                      final isOK = state!.saveAndValidate();
                      if (!isOK) return;

                      final data = state.value;
                      productCtrl().addInfoFromMap(data);

                      context.pop();
                    },
                    child: Text(TR.of(context).submit),
                  ),
                ),
              ),
              const Gap(Insets.med),
            ],
          ),
        ),
      ),
    );
  }
}
