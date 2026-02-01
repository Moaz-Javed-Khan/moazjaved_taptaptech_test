import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subTitle;
  final VoidCallback? onYesPressed;
  final VoidCallback? onNoPressed;
  final String? yesText;
  final String? noText;
  final Color? titleColor;
  final Color? contentColor;
  final Color? yesTextColor;
  final Color? noTextColor;
  final bool? singleButton;
  final List<Widget>? actions;

  const CustomDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.onYesPressed,
    this.onNoPressed,
    this.yesText,
    this.noText,
    this.titleColor,
    this.contentColor,
    this.yesTextColor,
    this.noTextColor,
    this.singleButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(
        top: 20,
        left: 8,
        right: 8,
        bottom: 0,
      ),
      actionsPadding: const EdgeInsets.only(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(width: 0.5, color: Colors.grey),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      actions:
          actions ??
          [
            const Divider(height: 1, thickness: 0.5, color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!(singleButton ?? false))
                  Expanded(
                    child: TextButton(
                      onPressed: onNoPressed,
                      child: Text(
                        noText ?? "No",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: noTextColor ?? Colors.red,
                        ),
                      ),
                    ),
                  ),
                if (!(singleButton ?? false))
                  Container(height: 24, width: 1, color: Colors.grey),
                Expanded(
                  child: TextButton(
                    onPressed: onYesPressed,
                    child: Text(
                      yesText ?? "Yes",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: yesTextColor ?? Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
    );
  }
}
