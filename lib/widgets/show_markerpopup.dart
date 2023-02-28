import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/my_theme.dart';

class ShowMarkerPopup extends StatefulWidget {
  final Widget child;
  final String? tooltip;
  final Function onTap;

  const ShowMarkerPopup({super.key, required this.child, this.tooltip, required this.onTap});

  @override
  State<ShowMarkerPopup> createState() => _ShowMarkerPopupState();
}

class _ShowMarkerPopupState extends State<ShowMarkerPopup> {
  final key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dynamic tooltip = key.currentState;
        tooltip.ensureTooltipVisible();
        widget.onTap();
      },
      enableFeedback: true,
      child: Container(
        child: Tooltip(
          key: key,
          message: widget.tooltip,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}