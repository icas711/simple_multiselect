import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'selector_provider.dart';

class MultiSelectDialog<T extends Object> extends StatelessWidget {
  final List<T> items;
  final List<T>? initialSelectedValues;
  final Widget? title;
  final TextStyle labelStyle;
  final Color? inactiveColor;
  final Color? activeColor;
  final String? closeButtonText;
  final String? selectAllTitle;
  final bool checkBox;

  const MultiSelectDialog({
    super.key,
    required this.items,
    this.initialSelectedValues,
    this.title,
    this.labelStyle = const TextStyle(),
    this.activeColor,
    this.inactiveColor,
    this.closeButtonText,
    this.selectAllTitle,
    this.checkBox = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectorProvider>(
      builder: (context, provider, _) {
        final selectedValues = provider.selectedItems;
        final List<Widget> listItems = [];
        if (selectAllTitle != null) {
          bool checked = true;
          for (var item in items) {
            if (!selectedValues.contains(item)) {
              checked = false;
              break;
            }
          }
          listItems.add(LayoutBuilder(
            builder: (context, constraints) {
              return InkWell(
                onTap: () {
                  if (checked) {
                    provider.clear();
                  } else {
                    provider.addAll(items);
                  }
                },
                child: checkBox
                    ? Row(
                        children: [
                          Checkbox(
                              value: checked,
                              onChanged: (value) {
                                if (checked) {
                                  provider.clear();
                                } else {
                                  provider.addAll(items);
                                }
                              }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(selectAllTitle!, style: labelStyle),
                          ),
                        ],
                      )
                    : Container(
                        width: constraints.maxWidth,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: checked ? activeColor : inactiveColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(selectAllTitle!, style: labelStyle),
                        ),
                      ),
              );
            },
          ));
          listItems.add(const Divider());
        }
        listItems.addAll(items.map((item) {
          final checked = selectedValues.contains(item);
          return LayoutBuilder(
            builder: (context, constraints) {
              return InkWell(
                onTap: () {
                  if (checked) {
                    provider.remove(item);
                  } else {
                    provider.add(item);
                  }
                },
                child: checkBox
                    ? Row(
                  children: [
                    Checkbox(
                        value: checked,
                        onChanged: (value) {
                          if (checked) {
                            provider.remove(item);
                          } else {
                            provider.add(item);
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.toString(), style: labelStyle),
                    ),
                  ],
                )
                    :Container(
                  width: constraints.maxWidth,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: checked ? activeColor : inactiveColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.toString(), style: labelStyle),
                  ),
                ),
              );
            },
          );
        }).toList());

        return Column(
          children: [
            Expanded(child: ListView(children: listItems)),
            if (closeButtonText != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(closeButtonText!),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
