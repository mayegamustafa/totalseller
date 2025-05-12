import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/features/add_product/controller/add_product_ctrl.dart';
import 'package:seller_management/main.export.dart';

class ProductWarrantyPolicySheet extends HookConsumerWidget {
  const ProductWarrantyPolicySheet({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PhysicalStoreState(:warrantyPolicy) =
        ref.watch(physicalStoreCtrlProvider(editingProduct));

    final productCtrl = useCallback(
        () => ref.read(physicalStoreCtrlProvider(editingProduct).notifier));

    final fieldKey = useMemoized(GlobalKey<FormBuilderTextState>.new);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: context.height * .8,
        child: SingleChildScrollView(
          child: ShadowContainer(
            padding: Insets.padAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TR.of(context).product_warranty_policy,
                  style: context.textTheme.titleLarge,
                ),
                const Gap(Insets.med),
                const Divider(),
                const Gap(Insets.med),
                Text(
                  TR.of(context).add_warranty_policy,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(Insets.sm),
                HtmlEditorView(
                  fieldKey: fieldKey,
                  name: 'warranty_policy',
                  initialValue: warrantyPolicy,
                  hint: TR.of(context).enter_warranty_policy,
                ),
                const Gap(Insets.offset),
                SubmitButton(
                  onPressed: (l) {
                    final value = fieldKey.currentState?.value;

                    productCtrl().copyWith(
                      (c) => c.copyWith(warrantyPolicy: () => value),
                    );

                    context.pop();
                  },
                  child: Text(
                    TR.of(context).submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
