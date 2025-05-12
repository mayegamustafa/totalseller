import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/features/auth/controller/auth_ctrl.dart';
import 'package:seller_management/features/kyc/controller/kyc_ctrl.dart';
import 'package:seller_management/features/kyc/view/kyc_logs_view.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';

import 'kyc_view.dart';

class VerifyKYCView extends HookConsumerWidget {
  const VerifyKYCView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(settingsCtrlProvider);
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    final kycCtrl = useCallback(() => ref.read(kycCtrlProvider.notifier));

    useEffect(
      () {
        Future.delayed(0.seconds, () {
          Toaster.showError(TR.of(context).kycVerificationMsg);
        });
        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(TR.of(context).kycVerification),
        actions: [
          IconButton(
            onPressed: () {
              context.nPush(const KYCLogsView());
            },
            icon: const Icon(Icons.list_rounded),
            tooltip: TR.of(context).viewKycLogs,
          ),
          IconButton(
            onPressed: () {
              ref.read(authCtrlProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout_outlined),
            tooltip: TR.of(context).logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: Insets.padAll,
        child: appSettings.when(
          loading: () => Loader.list(),
          error: (e, s) => ErrorView(e, s),
          data: (settings) {
            final kycConfig = settings.config.kycConfig;

            return FormBuilder(
              key: formKey,
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                separatorBuilder: () => const Gap(Insets.med),
                children: [
                  for (var field in kycConfig)
                    if (field.type == KYCType.file)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            field.labels,
                            style: context.textTheme.titleMedium?.bold,
                          ).markAsRequired(field.isRequired),
                          FormBuilderField<File>(
                            name: field.name,
                            validator: FormBuilderValidators.compose(
                              [
                                if (field.isRequired)
                                  FormBuilderValidators.required(),
                              ],
                            ),
                            builder: (state) {
                              final value = state.value;
                              return Row(
                                children: [
                                  Expanded(
                                    child: DecoratedContainer(
                                      color: context
                                          .theme.inputDecorationTheme.fillColor,
                                      borderRadius: Corners.med,
                                      height: 50,
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 4, 12, 4),
                                      child: value == null
                                          ? Text(
                                              field.placeholder,
                                              style:
                                                  context.textTheme.bodyMedium,
                                            )
                                          : Text(
                                              value.path.split('/').last,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                    ),
                                  ),
                                  if (field.type == KYCType.file)
                                    IconButton.outlined(
                                      onPressed: () async {
                                        final file =
                                            await locate<FilePickerRepo>()
                                                .pickFile(type: FileType.image);

                                        file.fold(
                                          (l) {},
                                          (r) => state.didChange(r),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add_photo_alternate_outlined,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            field.labels,
                            style: context.textTheme.titleMedium?.bold,
                          ).markAsRequired(field.isRequired),
                          const Gap(Insets.sm),
                          Row(
                            children: [
                              Flexible(
                                child: FormBuilderTextField(
                                  name: field.name,
                                  textInputAction: field.type.input.action,
                                  keyboardType: field.type.input.type,
                                  maxLines: field.type.maxLines,
                                  validator: FormBuilderValidators.compose(
                                    [
                                      if (field.isRequired)
                                        FormBuilderValidators.required(),
                                    ],
                                  ),
                                  decoration: InputDecoration(
                                    hintText: field.placeholder,
                                  ),
                                ),
                              ),
                              if (field.type == KYCType.date)
                                IconButton.outlined(
                                  onPressed: () async {
                                    final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now().add(29.days),
                                    );
                                    formKey.currentState?.fields[field.name]
                                        ?.didChange(date?.formatDate());
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                  const Gap(Insets.lg),
                  SubmitButton(
                    onPressed: (l) async {
                      final state = formKey.currentState!;
                      if (!state.saveAndValidate()) return;

                      l.value = true;

                      final values = state.value;

                      Map<String, File> files = {};
                      Map<String, String> data = {};

                      for (var MapEntry(:key, :value) in values.entries) {
                        if (value is File) {
                          files[key] = value;
                        } else {
                          data[key] = value.toString();
                        }
                      }

                      final kyc = await kycCtrl().submitKYC(data, files);
                      l.value = false;

                      if (!context.mounted || kyc == null) return;
                      context.nPush(KYCView(kyc));
                    },
                    child: Text(TR.of(context).submit),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
