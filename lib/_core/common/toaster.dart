import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:seller_management/main.export.dart';
import 'package:toastification/toastification.dart';

extension ToastificationItemEx on ToastificationItem {
  T andReturn<T>(T value) => value;
}

class Toaster {
  const Toaster._();

  static const Duration _animationDuration = Times.fast;
  static Duration autoCloseDuration =
      const Duration(seconds: 4) + _animationDuration;

  static ToastificationStyle? style = ToastificationStyle.flat;

  static AlignmentGeometry alignment = Alignment.topLeft;

  static GlobalKey<NavigatorState>? navigator;

  static OverlayEntry? overlayLoader;

  static ToastificationItem showLoading([String? msg, String? body]) {
    remove();

    return _loadingBuilder(msg ?? 'Loading...', body);
  }

  static ToastificationItem showSuccess(String? msg, [Function()? onTap]) {
    return _show(msg, type: ToastificationType.success, onTap: onTap);
  }

  static ToastificationItem showInfo(String? info, [Function()? onTap]) {
    return _show(info, onTap: onTap, type: ToastificationType.info);
  }

  static ToastificationItem showWarning(String? warning, [Function()? onTap]) {
    return _show(warning, onTap: onTap, type: ToastificationType.warning);
  }

  static ToastificationItem showError(Object? error, [Function()? onTap]) {
    var msg = error.toString();

    if (error is Failure) msg = error.message;

    return _show(msg, type: ToastificationType.error, onTap: onTap);
  }

  static ToastificationItem _show(
    String? msg, {
    required ToastificationType type,
    String? body,
    Duration? duration,
    Function()? onTap,
  }) {
    final nav = navigator?.currentState;
    if (nav == null) throw Exception('navigator not found');
    final ctx = nav.context;
    remove();

    return toastification.show(
      context: ctx,
      overlayState: nav.overlay,
      type: type,
      style: style,
      title: Text(msg ?? type.name.toTitleCase, maxLines: 2),
      description: body == null ? null : Text(body, maxLines: 3),
      alignment: alignment,
      autoCloseDuration: duration ?? autoCloseDuration,
      animationDuration: _animationDuration,
      borderRadius: Corners.lgBorder,
      boxShadow: highModeShadow,
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: false,
      backgroundColor: ctx.colors.surface,
      foregroundColor: ctx.colors.onSurface,
      showProgressBar: false,
      callbacks: ToastificationCallbacks(
        onTap: (value) => onTap?.call(),
      ),
    );
  }

  static ToastificationItem _loadingBuilder(String msg, String? body) {
    final nav = navigator?.currentState;
    if (nav == null) throw Exception('navigator not found');

    return toastification.showWithNavigatorState(
      navigator: nav,
      alignment: alignment,
      animationDuration: _animationDuration,
      autoCloseDuration: 365.days,
      builder: (context, holder) => _buildWidget(
        msg: msg,
        body: body,
        onCloseTap: () => Toastification().dismiss(holder),
      ),
    );
  }

  static Widget _buildWidget({
    required String? msg,
    String? body,
    VoidCallback? onCloseTap,
    ToastificationType? type,
  }) {
    final widget = _ToasterLoadingWidget(
      msg: msg,
      body: body,
      onCloseTap: onCloseTap,
      type: type,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: widget,
    );
  }

  static void remove() {
    toastification.dismissAll();
    removeShortLoader();
  }

  /// remember to call [Toaster.removeShortLoader] to remove the overlay
  static OverlayEntry showShortLoader([BuildContext? context]) {
    final ctx = context ?? navigator?.currentState?.context;
    if (ctx == null) throw Exception('context not found');

    return _ToastOver.showCompactLoader(ctx);
  }

  static void removeShortLoader([OverlayEntry? entry]) {
    overlayLoader?.remove();
    overlayLoader = null;
    entry?.remove();
  }
}

class _ToasterLoadingWidget extends HookWidget {
  const _ToasterLoadingWidget({
    required this.msg,
    this.type,
    this.body,
    this.onCloseTap,
  });

  final String? msg;
  final String? body;
  final VoidCallback? onCloseTap;

  /// Null is loader
  final ToastificationType? type;

  FlatStyle get style => FlatStyle(type ?? ToastificationType.success);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: Corners.lgBorder,
        boxShadow: highModeShadow,
      ),
      padding: style.padding(context),
      child: Row(
        children: [
          Icon(
            type != null ? style.icon(context) : Icons.hourglass_top_rounded,
            color: type != null
                ? style.iconColor(context)
                : context.colors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: BuiltInContent(
              style: style,
              title: Text(msg ?? type?.name.toTitleCase ?? '', maxLines: 2),
              description: body == null ? null : Text(body!),
              backgroundColor: context.colors.surface,
              foregroundColor: context.colors.onSurface,
              primaryColor: context.colors.primary,
              showProgressBar: type == null,
              progressBarWidget: LinearProgressIndicator(
                minHeight: 2,
                color: context.colors.primary,
                backgroundColor: context.colors.surface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _ToastCloseButton(
            onCloseTap: onCloseTap,
            icon: style.closeIcon(context),
            isLoader: type == null,
          ),
        ],
      ),
    );
  }
}

class _ToastCloseButton extends StatelessWidget {
  const _ToastCloseButton({
    required this.icon,
    required this.isLoader,
    this.onCloseTap,
  });

  final bool isLoader;
  final VoidCallback? onCloseTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 30,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                onCloseTap?.call();
                if (isLoader) _ToastOver.showCompactLoader(context);
              },
              borderRadius: BorderRadius.circular(5),
              child: Icon(
                icon,
                color: context.colors.onSurface.withOpacity(.5),
                size: 18,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ToastOver {
  const _ToastOver._();

  static OverlayEntry showCompactLoader(BuildContext context) {
    final entry = OverlayEntry(builder: (_) => const _OverlayLoadWidget());
    Toaster.overlayLoader = entry;

    Overlay.of(context).insert(entry);

    return entry;
  }
}

class _OverlayLoadWidget extends StatelessWidget {
  const _OverlayLoadWidget();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        child: LinearProgressIndicator(
          backgroundColor: Colors.transparent,
          minHeight: 2,
        ),
      ),
    );
  }
}
