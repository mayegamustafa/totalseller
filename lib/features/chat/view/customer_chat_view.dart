import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:seller_management/features/support_ticket/view/local/local.dart';
import 'package:seller_management/main.export.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/chat_ctrl.dart';
import 'local/customer_chat_bubble.dart';

class CustomerChatView extends HookConsumerWidget {
  const CustomerChatView({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageData = ref.watch(chatMessageCtrlProvider(id));
    final chatCtrl =
        useCallback(() => ref.read(chatMessageCtrlProvider(id).notifier));

    final msgCtrl = useTextEditingController();

    final files = useState<List<File>>([]);

    final refreshCtrl = RefreshController();

    final selected = useState<List<CustomerMessage>>([]);

    void addToSelected(CustomerMessage msg) {
      final contains = selected.value.map((e) => e.id).contains(msg.id);
      if (contains) {
        selected.value = selected.value.where((e) => e.id != msg.id).toList();
      } else {
        selected.value = [...selected.value, msg];
      }
    }

    final isSending = useState(false);

    return messageData.when(
      error: (e, s) => Scaffold(body: ErrorView(e, s)),
      loading: () => Scaffold(body: Loader.list()),
      data: (messagesData) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (selected.value.isEmpty) return context.pop();
              selected.value = [];
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: selected.value.isEmpty
              ? Text(messagesData.customer?.name ?? '')
              : Text('${selected.value.length}'),
          actions: [
            if (selected.value.isNotEmpty) ...[
              IconButton(
                onPressed: () {
                  final msgs = <String>[];
                  for (var msg in selected.value) {
                    final date = msg.dateTime.formatDate('dd/MM, hh:mm a');
                    msgs.add('[$date] ${msg.userName} : ${msg.message}');
                  }
                  Clipper.copy(msgs.join('\n'));
                },
                icon: const Icon(Icons.copy_rounded),
              ),
              IconButton(
                onPressed: () {
                  final msgs = <String>[];
                  for (var msg in selected.value) {
                    final date = msg.dateTime.formatDate('dd/MM, hh:mm a');
                    msgs.add('[$date] ${msg.userName} : ${msg.message}');
                  }
                  Share.share(msgs.join('\n'));
                },
                icon: const Icon(Icons.share_rounded),
              ),
            ],
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: SmartRefresher(
                controller: refreshCtrl,
                enablePullUp: true,
                reverse: true,
                physics: const AlwaysScrollableScrollPhysics(),
                onRefresh: () async {
                  await chatCtrl().reload();
                  refreshCtrl.refreshCompleted();
                },
                onLoading: () async {
                  final load = await chatCtrl().loadMore();
                  if (load case LoadStatus.failed) {
                    refreshCtrl.loadFailed();
                  }
                  if (load case LoadStatus.noMore) {
                    refreshCtrl.loadNoData();
                  }

                  await Future.delayed(1.seconds);
                  refreshCtrl.loadComplete();
                },
                child: CustomScrollView(
                  reverse: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverGroupedListView<CustomerMessage, DateTime>(
                      elements: messagesData.messages.listData,
                      groupBy: (e) => DateTime(
                        e.dateTime.year,
                        e.dateTime.month,
                        e.dateTime.day,
                        e.dateTime.hour,
                      ),
                      itemBuilder: (context, msg) {
                        final selectedMsg =
                            selected.value.map((e) => e.id).contains(msg.id);
                        return GestureDetector(
                          onLongPress: () {
                            if (selected.value.isEmpty) addToSelected(msg);
                          },
                          onTap: () {
                            if (selected.value.isNotEmpty) addToSelected(msg);
                          },
                          child: CustomerChatBubble(
                            msg: msg,
                            selected: selectedMsg,
                          ),
                        );
                      },
                      order: GroupedListOrder.DESC,
                      groupComparator: (v1, v2) => v1.compareTo(v2),
                      itemComparator: (e1, e2) =>
                          e1.dateTime.compareTo(e2.dateTime),
                      groupSeparatorBuilder: (value) => Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            value.formatDate('dd:MM:yyyy'),
                            style: context.textTheme.labelMedium!.copyWith(
                              color: context.colors.onSurface.withOpacity(.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: Insets.padH.copyWith(bottom: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (files.value.isEmpty) {
                        files.value = await chatCtrl().pickFiles();
                      } else {
                        showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          isScrollControlled: true,
                          builder: (_) => SelectedFilesSheet(files: files),
                        );
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: files.value.isEmpty
                          ? context.colors.outline.withOpacity(.6)
                          : context.colors.primary,
                      foregroundColor: files.value.isEmpty
                          ? context.colors.onSurface
                          : context.colors.onPrimary,
                      child: files.value.isEmpty
                          ? const RotationTransition(
                              turns: AlwaysStoppedAnimation(30 / 360),
                              child: Icon(Icons.attach_file),
                            )
                          : Text('${files.value.length}'),
                    ),
                  ),
                  const Gap(Insets.med),
                  Flexible(
                    child: TextFormField(
                      controller: msgCtrl,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      onTap: () {
                        if (selected.value.isNotEmpty) selected.value = [];
                      },
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                          maxHeight: context.height * 0.2,
                        ),
                        hintText: 'Write something...',
                      ),
                    ),
                  ),
                  const Gap(Insets.med),
                  IconButton.filled(
                    onPressed: () async {
                      isSending.value = true;
                      final result =
                          await chatCtrl().reply(msgCtrl.text, files.value);
                      isSending.value = false;
                      if (!result) return;

                      msgCtrl.clear();
                      files.value = [];
                    },
                    icon: isSending.value
                        ? SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              color: context.colors.onPrimary,
                              strokeWidth: 3,
                            ),
                          )
                        : Transform.rotate(
                            angle: -math.pi / 5,
                            child: const Icon(Icons.send_rounded),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
