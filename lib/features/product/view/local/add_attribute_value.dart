import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/features/settings/controller/auth_config_ctrl.dart';
import 'package:seller_management/main.export.dart';

import '../../controller/product_ctrl.dart';

class AddAttributeValueView extends HookConsumerWidget {
  const AddAttributeValueView({
    required this.attribute,
    required this.products,
    super.key,
  });

  final DigitalAttribute attribute;
  final ProductModel products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCtrl = useCallback(
        () => ref.read(productDetailsCtrlProvider(products.uid).notifier));

    final valueList = useState<List<DigitalAttributeValue>>([]);

    useEffect(() {
      valueList.value = attribute.values;

      return null;
    }, const []);

    Future<void> deleteValue(String id) async {
      await productCtrl().attributeValueDelete(id);

      valueList.value = valueList.value.where((e) => e.uid != id).toList();
    }

    Future<void> onSubmit(QMap data, [String? valueUid]) async {
      final ctrl = productCtrl();

      if (valueUid == null) {
        valueList.value = await ctrl.storeAttributeValue(attribute.uid, data);
      } else {
        valueList.value =
            await ctrl.updateAttributeValue(attribute.uid, valueUid, data);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(TR.of(context).attributeValue),
      ),
      body: SingleChildScrollView(
        padding: Insets.padAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: context.colors.primary.withOpacity(.09),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      showDragHandle: true,
                      builder: (context) => AddAttrValue(
                        onSubmit: (d) => onSubmit(d),
                      ),
                    );
                  },
                  label: Text(TR.of(context).addValue),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const Gap(Insets.def),
            if (valueList.value.isNotEmpty) ...[
              Text(
                TR.of(context).attributeValues,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(Insets.lg),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: valueList.value.length,
                separatorBuilder: (context, index) => const Gap(Insets.def),
                itemBuilder: (context, index) {
                  final value = valueList.value[index];

                  return ShadowContainer(
                    shadowColors:
                        context.colors.secondaryContainer.withOpacity(.03),
                    blurRadius: 40,
                    padding: Insets.padAll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                value.name,
                                style: context.textTheme.titleMedium,
                                maxLines: 1,
                              ),
                            ),
                            DecoratedContainer(
                              padding: Insets.padSym(5, 10),
                              color: value.isActive
                                  ? context.colors.errorContainer
                                      .withOpacity(.1)
                                  : context.colors.error.withOpacity(.1),
                              borderRadius: Corners.med,
                              child: Text(value.status),
                            ),
                          ],
                        ),
                        Text(
                          value.value,
                          style: context.textTheme.bodyLarge,
                        ),
                        SeparatedRow(
                          separatorBuilder: () => const Gap(Insets.med),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              value.createdAt,
                              style: context.textTheme.bodyLarge!.copyWith(
                                  color:
                                      context.colors.onSurface.withOpacity(.7)),
                            ),
                            SeparatedRow(
                              separatorBuilder: () => const Gap(Insets.sm),
                              children: [
                                if (value.file != null)
                                  DownloadButton(
                                    url: value.file!,
                                  ),
                                CircleIconButton(
                                  iconData: Icons.edit_rounded,
                                  color: context.colors.errorContainer,
                                  onTap: () async {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      showDragHandle: true,
                                      builder: (context) => AddAttrValue(
                                        onSubmit: (d) => onSubmit(d, value.uid),
                                        initial: value,
                                      ),
                                    );
                                  },
                                ),
                                CircleIconButton(
                                  iconData: Icons.delete_rounded,
                                  color: context.colors.error,
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DeleteAlert(
                                          title:
                                              'Really want to delete this Attribute?',
                                          onDelete: () async {
                                            await deleteValue(value.uid);
                                            if (context.mounted) context.nPop();
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AddAttrValue extends HookConsumerWidget {
  const AddAttrValue({
    super.key,
    required this.onSubmit,
    this.initial,
  });

  final Function(QMap data) onSubmit;
  final DigitalAttributeValue? initial;

  @override
  Widget build(context, ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

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
                physics: const AlwaysScrollableScrollPhysics(),
                padding: Insets.padAll,
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: context.textTheme.bodyLarge,
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'name',
                        initialValue: initial?.name,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Enter value name',
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      const Gap(Insets.def),
                      Text(
                        'Value',
                        style: context.textTheme.bodyLarge,
                      ).markAsRequired(),
                      const Gap(Insets.sm),
                      FormBuilderTextField(
                        name: 'value',
                        initialValue: initial?.value,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: const InputDecoration(
                          hintText: 'Enter value',
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      const Gap(Insets.def),
                      if (initial != null) ...[
                        Text(
                          'Status',
                          style: context.textTheme.bodyLarge,
                        ).markAsRequired(),
                        const Gap(Insets.sm),
                        FormBuilderDropField<int>(
                          name: 'status',
                          initialValue: initial?.statusKey,
                          itemCount: 2,
                          itemBuilder: (context, index) => DropdownMenuItem(
                            value: index,
                            child: Text(
                              index == 0 ? 'Inactive' : 'Active',
                            ),
                          ),
                          validators: [FormBuilderValidators.required()],
                        ),
                        const Gap(Insets.def),
                      ],
                      Text(
                        'File',
                        style: context.textTheme.bodyLarge,
                      ),
                      const Gap(Insets.sm),
                      FormBuilderField<MultipartFile>(
                        name: 'file',
                        // initialValue: initial ==null null,
                        builder: (state) {
                          final name = state.value?.filename ?? 'Select file';
                          return Row(
                            children: [
                              Expanded(
                                child: DecoratedContainer(
                                  color: context
                                      .theme.inputDecorationTheme.fillColor,
                                  borderRadius: Corners.med,
                                  padding: Insets.padAll,
                                  child: Text(
                                    name,
                                    style: context.textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                              const Gap(Insets.def),
                              InkWell(
                                onTap: () async {
                                  final types = ref.read(localAuthConfigProvider
                                      .select((x) => x?.attributeFileEx));

                                  final file =
                                      await locate<FilePickerRepo>().pickFile(
                                    allowedEx: types,
                                  );
                                  file.fold(
                                    (l) => Toaster.showError(l),
                                    (r) async {
                                      final mFile =
                                          await MultipartFile.fromFile(r.path);
                                      state.didChange(mFile);
                                    },
                                  );
                                },
                                child: DecoratedContainer(
                                  color: context.colors.primary.withOpacity(.1),
                                  padding: Insets.padAll,
                                  borderRadius: Corners.med,
                                  child: const Icon(Icons.attach_file_rounded),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const Gap(Insets.lg),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: Insets.padAll,
              child: SubmitButton(
                onPressed: (l) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;

                  final data = state.value;

                  l.value = true;
                  await onSubmit(data);
                  l.value = false;

                  state.reset();

                  if (context.mounted) context.nPop();
                },
                child: initial == null
                    ? Text(TR.of(context).addNew)
                    : Text(TR.of(context).update),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
