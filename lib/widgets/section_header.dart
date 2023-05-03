import 'package:flutter/material.dart';

class SectionHeader extends StatefulWidget {
  final String title;
  final String actionText;
  final String afterActionText;
  final Function action;
  const SectionHeader({
    Key? key,
    this.actionText = 'View more',
    this.afterActionText = 'View less',
    required this.title,
    required this.action,
  }) : super(key: key);

  @override
  State<SectionHeader> createState() => _SectionHeaderState();
}

class _SectionHeaderState extends State<SectionHeader> {
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        TextButton.icon(
          onPressed: () {
            widget.action();
            setState(() {
              _isClicked = !_isClicked;
            });
          },
          label: Text(
            _isClicked == true ? widget.afterActionText : widget.actionText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
          icon: _isClicked == true
              ? const Icon(Icons.keyboard_arrow_down_outlined,
                  color: Colors.white)
              : const Icon(Icons.keyboard_arrow_right_outlined,
                  color: Colors.white),
        ),
      ],
    );
  }
}
