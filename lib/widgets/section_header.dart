import 'package:flutter/material.dart';

class SectionHeader extends StatefulWidget {
  final String title;
  final String actionText;
  final String afterActionText;
  final bool showButton;
  final Function action;
  const SectionHeader({
    Key? key,
    this.actionText = 'View more',
    this.afterActionText = 'View less',
    required this.title,
    required this.action,
    this.showButton = true,
  }) : super(key: key);

  @override
  State<SectionHeader> createState() => _SectionHeaderState();
}

class _SectionHeaderState extends State<SectionHeader> {
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.background,
            fontSize: 20,
          ),
        ),
        if (widget.showButton)
          TextButton.icon(
            onPressed: () {
              widget.action();
              setState(() {
                _isClicked = !_isClicked;
              });
            },
            label: Text(
              _isClicked ? widget.afterActionText : widget.actionText,
              style: theme.textTheme.labelSmall!.copyWith(
                color: theme.colorScheme.background,
              ),
            ),
            icon: Icon(
              _isClicked
                  ? Icons.keyboard_arrow_down_outlined
                  : Icons.keyboard_arrow_right_outlined,
              color: theme.colorScheme.background,
            ),
          ),
      ],
    );
  }
}
