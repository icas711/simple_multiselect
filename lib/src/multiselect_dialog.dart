import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'selector_provider.dart';

class MultiSelectDialog<T extends Object> extends StatelessWidget {
  final List<T>? items;
  final List<T>? initialSelectedValues;
  final Widget? title;
  final TextStyle labelStyle;
  final Color? inactiveColor;
  final Color? activeColor;

  const MultiSelectDialog(
      {super.key,
        this.items,
        this.initialSelectedValues,
        this.title,
        this.labelStyle = const TextStyle(),
        this.activeColor,
        this.inactiveColor});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectorProvider>(builder: (context, provider, _) {
      final selectedValues = provider.selectedItems;
      final listItems = items!.map((item) {
        final checked = selectedValues.contains(item);
        return LayoutBuilder(builder: (context, constraints) {
          return InkWell(
            onTap: () {
              if (checked) {
                provider.remove(item);
              } else {
                provider.add(item);
              }
            },
            child: Container(
              width: constraints.maxWidth,
              padding: const EdgeInsets.all(8),
              decoration:
              BoxDecoration(color: checked ? activeColor : inactiveColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.toString(),
                  style: labelStyle,
                ),
              ),
            ),
          );
        });
      }).toList();

      return ListView(
        children: listItems,
      );
    });
  }
}
