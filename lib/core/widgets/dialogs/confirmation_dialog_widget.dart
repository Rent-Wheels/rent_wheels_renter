import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/popups/confirmation_popup_widget.dart';

buildConfirmationDialog({
  String? message,
  required String label,
  required String buttonName,
  required BuildContext context,
  required void Function()? onAccept,
}) =>
    showDialog(
      context: context,
      builder: (context) => buildConfirmationPopup(
        label: label,
        message: message,
        context: context,
        onCancel: () => Navigator.pop(context),
        onAccept: onAccept,
        buttonName: buttonName,
      ),
    );
