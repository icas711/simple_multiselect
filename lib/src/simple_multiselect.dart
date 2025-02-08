import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'multiselect_dialog.dart';
import 'selector_provider.dart';
import 'num.dart';

class MultiSelectField<T extends Object> extends StatelessWidget {
  ///Multi select widget from selectable list
  const MultiSelectField({
    super.key,
    this.hintWidget = const Text('Choose items'),
    required this.dataSource,
    this.labelStyle = const TextStyle(),
    this.labelBackgroundColor = const Color(0xFFCCCCCC),
    this.labelBorder = const BorderRadius.all(Radius.circular(10)),
    this.labelBorderColor = const Color(0xFF7C7C7C),
    this.inputDecoration = const InputDecoration(border: InputBorder.none),
    this.dialogTextStyle = const TextStyle(),
    this.modalHeight = 0.7,
    this.activeColor = const Color(0xFFCCCCCC),
    this.inactiveColor = Colors.transparent,
    required this.onChange,
  });

  ///Set hint, as [Widget]: Text('type something')

  final Widget hintWidget;

  ///Set list of objects
  ///when pass from class, need to override method "toString"
  ///example:
  ///@override
  ///String toString() {
  ///     return title;
  ///   }
  final List<T>? dataSource;

  ///Label background color
  final Color? labelBackgroundColor;

  ///Used to set border geometry for labels in main list
  final BorderRadiusGeometry? labelBorder;

  final Color? labelBorderColor;

  ///Set decoration of input text
  final InputDecoration? inputDecoration;

  ///Used for text style in modal window
  final TextStyle dialogTextStyle;

  ///Set height of madal window from 0.0 to 1.0
  ///If value 1.0 get height of screen
  final double modalHeight;

  ///Set color of items in selectable list
  final Color? inactiveColor;

  ///Set color of checked items in selectable list
  final Color? activeColor;

  ///Set style of text in selectable list
  final TextStyle? labelStyle;

  final void Function(List<Object>) onChange;
  @override
  Widget build(BuildContext context) {
    final SelectorProvider selectorProvider = SelectorProvider(onChange);
    return ChangeNotifierProvider<SelectorProvider>.value(
      value: selectorProvider,
      child: InkWell(
        onTap: () async {
          List<T>? initialSelected = [];

          await showModalBottomSheet<List>(
            context: context,
            isScrollControlled: true,
            shape: const ContinuousRectangleBorder(),
            builder: (BuildContext ctx) {
              return ChangeNotifierProvider<SelectorProvider>.value(
                value: selectorProvider,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      modalHeight.setNumInBounds(),
                  child: MultiSelectDialog<T>(
                    items: dataSource,
                    initialSelectedValues: initialSelected,
                    labelStyle: dialogTextStyle,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                  ),
                ),
              );
            },
          );
        },
        child: InputDecorator(
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          child: Consumer<SelectorProvider>(builder: (context, items, _) {
            return SingleChildScrollView(
              child: items.selectedItems.isNotEmpty
                  ? Wrap(
                      spacing: 28.0,
                      runSpacing: 8.0,
                      children: items.selectedItems
                          .map(
                            (e) => Container(
                              decoration: BoxDecoration(
                                color: labelBackgroundColor,
                                borderRadius: labelBorder,
                                border: Border.all(color: labelBorderColor!),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child:
                                        Text(e.toString(), style: labelStyle),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: () {
                                      items.remove(e);
                                    },
                                    icon: const Icon(CupertinoIcons.clear),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Container(
                      padding: const EdgeInsets.only(top: 4),
                      child: hintWidget,
                    ),
            );
          }),
        ),
      ),
    );
  }
}
