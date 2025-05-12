import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:seller_management/features/chat/controller/chat_file_downloader.dart';
import 'package:seller_management/main.export.dart';

class CustomerChatBubble extends HookConsumerWidget {
  const CustomerChatBubble({
    super.key,
    required this.msg,
    required this.selected,
  });
  final CustomerMessage msg;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: context.colors.primary.withOpacity(selected ? .1 : 0),
      padding: Insets.padH,
      child: Column(
        crossAxisAlignment:
            msg.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            constraints: BoxConstraints(maxWidth: context.width / 1.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selected
                  ? context.colors.primary.withOpacity(.1)
                  : context.colors.onSurface.withOpacity(.05),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: ParsedText(
              text: msg.message,
              style: context.textTheme.bodyLarge,
              parse: [
                MatchText(
                  type: ParsedType.PHONE,
                  onTap: (x) => URLHelper.call(x),
                  style: context.textTheme.bodyLarge?.textColor(
                    context.colors.primary.withOpacity(.7),
                  ),
                ),
                MatchText(
                  type: ParsedType.EMAIL,
                  onTap: (x) => URLHelper.mail(x),
                  style: context.textTheme.bodyLarge?.textColor(
                    context.colors.primary.withOpacity(.7),
                  ),
                ),
                MatchText(
                  type: ParsedType.URL,
                  onTap: (x) => URLHelper.url(x),
                  style: context.textTheme.bodyLarge?.textColor(
                    context.colors.primary.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),
          const Gap(Insets.sm),
          if (msg.files.isNotEmpty) ...[
            _ChatFiles(msg: msg),
            const Gap(Insets.sm),
          ],
          if (msg.isMine && msg.isSeen)
            Icon(
              Icons.done_all_outlined,
              size: 18,
              color: context.colors.primary.withOpacity(0.7),
            ),
        ],
      ),
    );
  }
}

class _ChatFiles extends HookConsumerWidget {
  const _ChatFiles({
    required this.msg,
  });

  final CustomerMessage msg;

  @override
  Widget build(BuildContext context, ref) {
    final downloadQueue = ref.watch(chatFileDownloaderProvider);
    final downloader =
        useCallback(() => ref.read(chatFileDownloaderProvider.notifier));

    return SizedBox(
      width: context.width * 0.7,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: msg.files.length,
        itemBuilder: (context, index) {
          final download = downloadQueue
              .where((f) => f.url == msg.files[index].url)
              .firstOrNull;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.onSurface.withOpacity(.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        downloader().addToQueue(msg.files[index]);
                      },
                      child: CircleAvatar(
                        backgroundColor: context.colors.primary,
                        child: download == null
                            ? Icon(
                                Icons.download_rounded,
                                color: context.colors.onPrimary,
                              )
                            : (download.progress?.isNegative ?? false)
                                ? Icon(
                                    Icons.file_open_rounded,
                                    color: context.colors.onPrimary,
                                  )
                                : CircularProgressIndicator(
                                    value: download.progress,
                                    color: context.colors.onPrimary,
                                  ),
                      ),
                    ),
                    const Gap(Insets.med),
                    SizedBox(
                      width: context.width / 5.5,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'File ${index + 1}',
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\n${msg.files[index].name.split('.').last}',
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
