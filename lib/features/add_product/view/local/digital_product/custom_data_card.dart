import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/features/add_product/controller/add_digital_ctrl.dart';
import 'package:seller_management/main.export.dart';

class CustomDataCard extends HookConsumerWidget {
  const CustomDataCard({
    super.key,
    required this.editingProduct,
  });

  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(digitalStoreCtrlProvider(editingProduct));
    final productCtrl = useCallback(
        () => ref.read(digitalStoreCtrlProvider(editingProduct).notifier));

    final showOptionsField = useState(false);
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    return FormBuilder(
      key: formKey,
      child: ExpansionTile(
        maintainState: true,
        tilePadding: const EdgeInsets.all(0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(
          'Custom Data',
          style: context.textTheme.titleLarge,
        ),
        children: [
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Field name',
                      style: context.textTheme.bodyMedium?.bold,
                    ),
                    FormBuilderTextField(
                      name: 'data_name',
                      validator: FormBuilderValidators.required(),
                      decoration: const InputDecoration(
                        hintText: 'name',
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(Insets.def),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Field label',
                      style: context.textTheme.bodyMedium?.bold,
                    ),
                    FormBuilderTextField(
                      name: 'data_label',
                      validator: FormBuilderValidators.required(),
                      decoration: const InputDecoration(
                        hintText: 'label',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(Insets.med),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Field type',
                      style: context.textTheme.bodyMedium?.bold,
                    ),
                    FormBuilderDropField<String>(
                      name: 'type',
                      hintText: 'type',
                      onChanged: (v) => showOptionsField.value = v == 'select',
                      itemCount: KFieldType.values.length,
                      validators: [FormBuilderValidators.required()],
                      itemBuilder: (c, i) {
                        const types = KFieldType.values;
                        final e = types[i];
                        return DropdownMenuItem(
                          value: e.name,
                          child: Text(e.name.titleCaseSingle),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Gap(Insets.def),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'is required field',
                      style: context.textTheme.bodyMedium?.bold,
                    ),
                    FormBuilderField<bool>(
                      name: 'data_required',
                      initialValue: false,
                      validator: FormBuilderValidators.required(),
                      builder: (state) {
                        return Card(
                          color: context.theme.inputDecorationTheme.fillColor,
                          elevation: 0,
                          child: Padding(
                            padding: Insets.padH,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: state.value,
                                  onChanged: (v) => state.didChange(v),
                                ),
                                Text(TR.of(context).required),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showOptionsField.value) ...[
            const Gap(Insets.def),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selectable options',
                  style: context.textTheme.bodyMedium?.bold,
                ),
                FormBuilderTextField(
                  enabled: showOptionsField.value,
                  name: 'data_value',
                  validator: showOptionsField.value
                      ? FormBuilderValidators.required()
                      : null,
                  decoration: const InputDecoration(
                    hintText: 'comma separated options',
                  ),
                ),
              ],
            ),
          ],
          const Gap(Insets.def),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    final state = formKey.currentState!;
                    if (!state.saveAndValidate()) return;
                    final data = state.value;

                    productCtrl().addCustomData(data);

                    state.reset();
                  },
                  icon: const Icon(Icons.add),
                  label: Text(TR.of(context).addCustomData),
                ),
              ),
              const Gap(Insets.sm),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: Corners.medBorder,
                  side: BorderSide(
                    color: context.colors.outline,
                  ),
                ),
                elevation: 0,
                child: InkWell(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    builder: (c) => ProductBrandSheet(
                      editingProduct: editingProduct,
                    ),
                  ),
                  child: Padding(
                    padding: Insets.padSym(8, 10),
                    child: Row(
                      children: [
                        Text('${TR.of(context).added} : '),
                        Text(
                          '${productState.customerData?.length ?? 0}',
                          style: context.textTheme.titleMedium?.semiBold
                              .textColor(context.colors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(Insets.med),
        ],
      ),
    );
  }
}

class ProductBrandSheet extends HookConsumerWidget {
  const ProductBrandSheet({
    super.key,
    required this.editingProduct,
  });
  final ProductModel? editingProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(digitalStoreCtrlProvider(editingProduct));
    final productCtrl = useCallback(
        () => ref.read(digitalStoreCtrlProvider(editingProduct).notifier));
    final customerData = productState.customerData ?? [];

    final tr = TR.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.mq.viewInsets.bottom,
      ),
      child: SizedBox(
        height: context.height * 0.7,
        width: context.width,
        child: ShadowContainer(
          child: Padding(
            padding: Insets.padAll,
            child: SingleChildScrollView(
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                separatorBuilder: () => const Gap(Insets.sm),
                children: [
                  for (var i = 0; i < customerData.length; i++)
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              context.colors.outline.withOpacity(.3),
                          foregroundColor: context.colors.primary,
                          child: Text('${i + 1}'),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr.fieldName(': ${customerData[i].name}')),
                            Text(
                              tr.fieldLabel(': ${customerData[i].label}'),
                              maxLines: 1,
                            ),
                            Text(
                              tr.fieldType(
                                ': ${customerData[i].type.name.titleCaseSingle}',
                              ),
                            ),
                            Text(
                              customerData[i].isRequired
                                  ? tr.required
                                  : tr.notRequired,
                            ),
                            if (customerData[i].options != null)
                              Text(
                                tr.field_options(
                                  ': ${customerData[i].options}',
                                ),
                              ),
                          ],
                        ),
                        trailing: IconButton.outlined(
                          style: IconButton.styleFrom(
                            foregroundColor: context.colors.error,
                          ),
                          onPressed: () => productCtrl()
                              .removeCustomData(customerData[i].id),
                          icon: const Icon(Icons.delete_rounded),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
