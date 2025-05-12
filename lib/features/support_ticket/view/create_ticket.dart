import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';

import '../../../routes/go_route_name.dart';
import '../controller/ticket_massage_ctrl.dart';

class CreateTicketView extends HookConsumerWidget {
  const CreateTicketView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final ticketData = ref.watch(ticketCreateProvider);
    final createTicket =
        useCallback(() => ref.watch(ticketCreateProvider.notifier));
    final priority = ref.watch(localSettingsProvider
        .select((v) => v?.config.ticketPriority.enumData.entries.toList()));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TR.of(context).support_ticket,
        ),
      ),
      body: Padding(
        padding: Insets.padAll,
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TR.of(context).support_ticket_create,
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
                                TR.of(context).subject,
                                style: context.textTheme.bodyLarge,
                              ).markAsRequired(),
                              const Gap(Insets.sm),
                              FormBuilderTextField(
                                name: 'subject',
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: TR.of(context).enter_subject,
                                ),
                                validator: FormBuilderValidators.required(),
                              ),
                              const Gap(Insets.med),
                              Text(
                                TR.of(context).massage,
                                style: context.textTheme.bodyLarge,
                              ).markAsRequired(),
                              const Gap(Insets.sm),
                              FormBuilderTextField(
                                name: 'message',
                                keyboardType: TextInputType.multiline,
                                validator: FormBuilderValidators.required(),
                                textInputAction: TextInputAction.newline,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: TR.of(context).enter_massage,
                                  alignLabelWithHint: true,
                                ),
                              ),
                              const Gap(Insets.med),
                              Text(
                                TR.of(context).priority,
                                style: context.textTheme.bodyLarge,
                              ).markAsRequired(),
                              const Gap(Insets.sm),
                              if (priority != null)
                                FormBuilderDropField<String>(
                                  name: 'priority',
                                  hintText: TR.of(context).select_priority,
                                  itemCount: priority.length,
                                  itemBuilder: (context, index) {
                                    final pri = priority[index];
                                    return DropdownMenuItem(
                                      value: pri.value.toString(),
                                      child: Text(pri.key),
                                    );
                                  },
                                  validators: [
                                    FormBuilderValidators.required(),
                                  ],
                                ),
                              const Gap(Insets.lg),
                              Text(
                                TR.of(context).select_file,
                                style: context.textTheme.bodyLarge,
                              ),
                              const Gap(Insets.sm),
                              GestureDetector(
                                onTap: () {
                                  createTicket().pickFiles();
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: context.colors.onSurface
                                        .withOpacity(.05),
                                    borderRadius: Corners.medBorder,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.attach_file,
                                        size: 20,
                                        color: context.colors.primary,
                                      ),
                                      const Gap(Insets.med),
                                      Text(
                                        TR.of(context).select,
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: context.colors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ticketData.files.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Corners.med),
                              side: BorderSide(
                                color: context.colors.secondaryContainer,
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.file_present_rounded,
                                size: 30,
                                color: context.colors.secondaryContainer,
                              ),
                              title: Text(
                                ticketData.files[index].path.split('/').last,
                              ),
                              trailing: IconButton(
                                style: IconButton.styleFrom(
                                  foregroundColor: context.colors.error,
                                ),
                                onPressed: () =>
                                    createTicket().removeFile(index),
                                icon: const Icon(Icons.clear_rounded),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: SubmitButton(
                onPressed: (isLoading) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;
                  createTicket().setTicketInfo(state.value);
                  final id = await createTicket().createTicket();
                  state.reset();
                  if (id != null && context.mounted) {
                    RouteNames.ticket.goNamed(context, pathParams: {'id': id});
                  }
                },
                child: Text(TR.of(context).create_ticket),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
