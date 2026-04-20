import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum ToastKind {
  success,
  error,
  alert,
}

class AppToast {
  static Future show({
    required BuildContext context,
    required ToastKind kind,
    required String text,
    String? actionLabel,
    VoidCallback? onAction,
  }) async {
    const Duration duration = Duration(seconds: 4);
    const Duration animationDuration = Duration(milliseconds: 450);

    // Cores e ícones por tipo
    Color kindColor;
    IconData kindIcon;
    switch (kind) {
      case ToastKind.success:
        kindColor = Colors.green;
        kindIcon = Icons.check_circle_outline;
        break;
      case ToastKind.error:
        kindColor = Colors.red;
        kindIcon = Icons.error_outline;
        break;
      case ToastKind.alert:
        kindColor = Colors.orange;
        kindIcon = Icons.warning_amber_outlined;
        break;
    }

    // Altura dinâmica
    double toastHeight = 100;
    if (text.length > 80) toastHeight = 140;

    final media = MediaQuery.of(context);
    final topPadding = media.padding.top; // Respeita notch
    final fullWidth = media.size.width;

    // Cor do texto ajustada ao tema
    final textColor = Theme.of(context).colorScheme.onSurface;

    showToastWidget(
      Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: fullWidth,
            child: Container(
              height: toastHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16), // cantos mais suaves
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Barra lateral esquerda contínua
                  Container(
                    width: 8,
                    decoration: BoxDecoration(
                      color: kindColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Conteúdo principal
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          kindIcon,
                          color: kindColor,
                          size: 30,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              color: textColor,
                            ),
                          ),
                        ),
                        if (actionLabel != null)
                          InkWell(
                            onTap: () {
                              ToastManager().dismissAll();
                              onAction?.call();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                actionLabel,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kindColor,
                                ),
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () => ToastManager().dismissAll(),
                          child: Icon(
                            Icons.close,
                            color: kindColor,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      position: StyledToastPosition.top,
      startOffset: const Offset(0.0, -1.0),
      reverseEndOffset: const Offset(0.0, -1.0),
      duration: duration,
      animDuration: animationDuration,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
  }

  static void success({
    required BuildContext context,
    required String text,
  }) {
    show(
      context: context,
      kind: ToastKind.success,
      text: text,
      //actionLabel: 'OK',
    );
  }

  static void error({
    required BuildContext context,
    required String text,
  }) {
    show(
      context: context,
      kind: ToastKind.error,
      text: text,
    );
  }

  static void alert({
    required BuildContext context,
    required String text,
  }) {
    show(
      context: context,
      kind: ToastKind.alert,
      text: text,
    );
  }
}