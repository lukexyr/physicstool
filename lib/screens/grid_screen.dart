import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:physicstool/components/my_button.dart';
import 'package:physicstool/pages/drop_zone.dart';
import 'package:physicstool/pages/grid_page.dart';
import 'package:physicstool/pages/my_grid_naming.dart';
import 'package:physicstool/pages/my_grid_builder.dart';

class GridScreen extends StatefulWidget {
  GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  int _columns = 4;
  int _rows = 3;
  final TextEditingController _controller = TextEditingController();
  late List _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      GridPage(
        columns: _columns,
        rows: _rows,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1),
              ),
              child: Expanded(
                child: _pages[0],
              ),
            ),
            const SizedBox(width: 20), // Abstand zwischen den Containern
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropZone(),
                SizedBox(height: 20),
                MyGridBuilder(
                  onChangedColumns: (value) {
                    setState(() {
                      _columns = value;
                      _pages[0] = GridPage(
                        columns: _columns,
                        rows: _rows,
                      );
                    });
                  },
                  onChangedRows: (value) {
                    setState(() {
                      _rows = value;
                      _pages[0] = GridPage(
                        columns: _columns,
                        rows: _rows,
                      );
                    });
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
