import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:seller_management/features/region/controller/region_ctrl.dart';
import 'package:seller_management/features/settings/controller/settings_ctrl.dart';
import 'package:seller_management/main.export.dart';

class LanguageView extends HookConsumerWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langCode = ref.watch(regionCtrlProvider.select((v) => v.langCode));
    final languages = ref
        .watch(localSettingsProvider.select((value) => value?.languages ?? []));

    final animationController = useAnimationController(duration: Times.def);
    final animation = useAnimation(animationController);

    final selected = languages.firstWhereOrNull((e) => e.code == langCode);

    useEffect(() {
      animationController.forward(from: 0.0);
      return null;
    }, [langCode]);

    final WidgetStateProperty<Icon?> thumbIcon =
        WidgetStateProperty.resolveWith(
      (states) {
        if (states.isSelected) return const Icon(Icons.check);
        return const Icon(Icons.close, color: Colors.white);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(TR.of(context).language),
      ),
      body: SingleChildScrollView(
        padding: Insets.padAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TR.of(context).selected_language,
              style: context.textTheme.titleLarge,
            ),
            const Gap(16),
            Opacity(
              opacity: animation,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.primary.withOpacity(.05),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 0, color: context.colors.primary),
                ),
                child: Padding(
                  padding: Insets.padAll,
                  child: Row(
                    children: [
                      if (selected != null)
                        CircleImage(
                          selected.image,
                          radius: 20,
                        )
                      else
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: context.colors.primary,
                          child: Text(
                            langCode.toUpperCase(),
                            style: context.textTheme.titleLarge!.copyWith(
                              color: context.colors.primary,
                            ),
                          ),
                        ),
                      const Gap(16),
                      Text(
                        selected?.name ?? langCode.toUpperCase(),
                        style: context.textTheme.titleLarge!.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(Insets.lg),
            const Divider(),
            const Gap(Insets.med),
            Text(
              TR.of(context).all_language,
              style: context.textTheme.titleLarge,
            ),
            const Gap(16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                return SwitchListTile(
                  secondary: CircleImage(
                    language.image,
                    radius: 20,
                  ),
                  title: Text(
                    language.name,
                    style: context.textTheme.titleLarge,
                  ),
                  value: langCode == language.code,
                  inactiveThumbColor: context.colors.primary,
                  inactiveTrackColor: context.colors.primary.withOpacity(.05),
                  thumbIcon: thumbIcon,
                  onChanged: (value) {
                    if (value) {
                      ref
                          .read(regionCtrlProvider.notifier)
                          .setLanguage(language.code);
                      ref
                          .read(localeProvider.notifier)
                          .setFromCode(language.code);

                      animationController.forward(from: 0.0);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
