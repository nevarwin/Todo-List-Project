import 'package:flutter/material.dart';
import '../provider/todo.dart';

class ImportanceChipWidget extends StatefulWidget {
  ImportanceChipWidget({
    Key? key,
    required this.chipTitle,
    required this.chipVar,
    required this.importanceChip,
  }) : super(key: key);
  final String chipTitle;

  Importance chipVar;

  Importance importanceChip;

  @override
  State<ImportanceChipWidget> createState() => _ImportanceChipWidgetState();
}

class _ImportanceChipWidgetState extends State<ImportanceChipWidget> {
  Importance _importance = Importance.low;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selectedColor: const Color.fromRGBO(255, 182, 115, 1),
      label: Text(widget.chipTitle),
      selected: widget.chipVar == widget.importanceChip,
      onSelected: (selected) {
        setState(() {
          _importance = widget.importanceChip;
        });
      },
    );
  }
}
