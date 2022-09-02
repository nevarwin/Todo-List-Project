import 'package:flutter/material.dart';
import '../provider/todo.dart';

class LabelChipWidget extends StatefulWidget {
  LabelChipWidget({
    Key? key,
    required this.chipTitle,
    required this.chipVar,
    required this.labelChip,
  }) : super(key: key);

  String chipTitle;
  Label chipVar;
  Label labelChip;

  @override
  State<LabelChipWidget> createState() => _LabelChipWidgetState();
}

class _LabelChipWidgetState extends State<LabelChipWidget> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selectedColor: const Color.fromRGBO(255, 182, 115, 1),
      label: Text(widget.chipTitle),
      selected: widget.chipVar == widget.labelChip,
      onSelected: (selected) {
        setState(() {
          Label _label = Label.todo;

          _label = widget.labelChip;
        });
      },
    );
  }
}
