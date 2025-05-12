import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/features/product/controller/product_ctrl.dart';
import 'package:seller_management/main.export.dart';

class AddDigitalProductAttribute extends HookConsumerWidget {
  const AddDigitalProductAttribute({
    super.key,
    required this.product,
    this.attribute,
  });

  final ProductModel product;
  final DigitalAttribute? attribute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCtrl = useCallback(
      () => ref.read(productDetailsCtrlProvider(product.uid).notifier),
    );

    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    final isUpdate = attribute != null;

    final tr = TR.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: context.height * .8,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: Insets.padAll,
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr.attributeName).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'name',
                        initialValue: attribute?.name,
                        decoration: InputDecoration(
                          hintText: tr.enterAttributeName,
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      const Gap(Insets.med),
                      Text(tr.price).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'price',
                        initialValue: attribute?.price.toString(),
                        decoration: InputDecoration(
                          hintText: tr.enterAttributePrice,
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      const Gap(Insets.med),
                      if (isUpdate) ...[
                        Text(
                          tr.status,
                          style: context.textTheme.bodyLarge,
                        ).markAsRequired(),
                        const Gap(Insets.sm),
                        FormBuilderDropField<int>(
                          name: 'status',
                          initialValue: attribute!.isActive ? 1 : 0,
                          itemCount: 2,
                          itemBuilder: (context, index) => DropdownMenuItem(
                            value: index,
                            child: Text(
                              index == 0 ? tr.inactive : tr.active,
                            ),
                          ),
                          validators: [FormBuilderValidators.required()],
                        ),
                        const Gap(Insets.med),
                      ],
                      Text(
                        'Sort Description',
                        style: context.textTheme.bodyLarge,
                      ),
                      const Gap(Insets.sm),
                      SizedBox(
                        height: 100,
                        child: FormBuilderTextField(
                          name: 'short_details',
                          initialValue: attribute?.shortDetails,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: 'Enter Sort Description',
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                      const Gap(Insets.xl),
                      const Gap(Insets.med),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: Insets.padAll,
              child: SubmitButton(
                onPressed: (isLoading) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;

                  isLoading.value = true;
                  if (isUpdate) {
                    await productCtrl()
                        .attributeUpdate(attribute!.uid, state.value);
                  } else {
                    await productCtrl().attributeStore(state.value);
                  }
                  isLoading.value = false;

                  if (context.mounted) context.nPop();
                },
                child:
                    isUpdate ? Text(tr.updateAttribute) : Text(tr.addAttribute),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
