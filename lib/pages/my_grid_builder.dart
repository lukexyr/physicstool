import 'package:flutter/material.dart';

class MyGridBuilder extends StatefulWidget {
  final ValueChanged<int>? onChangedColumns;
  final ValueChanged<int>? onChangedRows;

  const MyGridBuilder({Key? key, this.onChangedColumns, this.onChangedRows})
      : super(key: key);

  @override
  State<MyGridBuilder> createState() => _SettingsState();
}

class _SettingsState extends State<MyGridBuilder> {
  int _columns = 4;
  int _rows = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Columns:'),
                const SizedBox(width: 10),
                DropdownButton<int>(
                  elevation: 0,
                  value: _columns,
                  items: [1, 2, 3, 4, 5].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      _columns = value!;
                    });
                    widget.onChangedColumns?.call(value!);
                  },
                ),
              ],
            ),
            const SizedBox(width: 15),
            Row(
              children: [
                Text('Rows:'),
                SizedBox(width: 10),
                DropdownButton<int>(
                  elevation: 0,
                  value: _rows,
                  items: [1, 2, 3, 4, 5].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      _rows = value!;
                    });
                    widget.onChangedRows?.call(value!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
