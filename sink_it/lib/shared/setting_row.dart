//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';

class SettingRow extends StatefulWidget {
  const SettingRow({
    required this.icon,
    required this.subtext,
    required this.text,
    required this.initialValue,
    required this.onChanged,
    super.key,
  });

  final Icon icon;
  final Widget text;
  final Widget subtext;
  final bool initialValue;
  final Function(bool) onChanged;

  @override
  State<SettingRow> createState() => _SettingRowState();
}

class _SettingRowState extends State<SettingRow> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.icon,
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [widget.text, widget.subtext],
        ),
        Spacer(),
        Switch(
          value: isOn,

          onChanged: (bool value) {
            setState(() {
              isOn = value;
            });
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
