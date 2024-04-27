import 'package:flutter/material.dart';
import 'package:physicstool/pages/my_grid_naming.dart';

class GridPage extends StatefulWidget {
  final int columns;
  final int rows;

  GridPage({Key? key, required this.columns, required this.rows})
      : super(key: key);

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  int? _selectedIndex;
  late List<bool> isSelected;
  late List<String> containerTexts;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateSelectedList();
  }

  void updateSelectedList() {
    isSelected = List.generate(widget.columns * widget.rows, (index) => false);
    containerTexts = List.generate(widget.columns * widget.rows, (index) => '');
  }

  void _selectContainer(int index) {
    setState(() {
      if (_selectedIndex != null) {
        isSelected[_selectedIndex!] = false;
      }
      isSelected[index] = true;
      _selectedIndex = index;

      // Set text of selected container to TextField
      _controller.text = containerTexts[_selectedIndex!];
    });
  }

  void _updateContainerText(String text) {
    if (_selectedIndex != null) {
      setState(() {
        containerTexts[_selectedIndex!] = text;
      });
    }
  }

  @override
  void didUpdateWidget(covariant GridPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.columns != widget.columns || oldWidget.rows != widget.rows) {
      updateSelectedList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            MyGridNaming(
              controller: _controller,
              onTextChanged: _updateContainerText,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.columns,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  padding: EdgeInsets.all(8.0),
                  itemCount: widget.columns * widget.rows,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _selectContainer(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: isSelected[index] ? Colors.blue : Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            containerTexts[index],
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
