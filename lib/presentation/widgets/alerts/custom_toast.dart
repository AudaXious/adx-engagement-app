import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void show({
    required BuildContext context,
    required String title,
    required String description,
    ToastificationType? type,
  }) {
    toastification.show(
      context: context,
      title: Text(title),
      description: Text(description),
      type: type ?? ToastificationType.info,
      applyBlurEffect: true,
      alignment: Alignment.topCenter,
      autoCloseDuration: type == ToastificationType.error
          ? const Duration(seconds: 4)
          : const Duration(seconds: 3),
    );
  }
}
