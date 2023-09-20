import 'package:flutter/material.dart';

class MyTodoList extends StatefulWidget {
  const MyTodoList({super.key});

  @override
  State<MyTodoList> createState() => MyTodoListState();
}

class MyTodoListState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class WidgetFoo extends StatefulWidget {
//   final String varFromFoo = 'foo';
//   @override
//   State<StatefulWidget> createState() => WidgetFooState<WidgetFoo>();
// }

// // Don't make this class name private (beginning with _) to allow its usage in other modules.
// class WidgetFooState <T extends StatefulWidget> extends State<T> {
//   String varFromFooState = 'foo state';
//   @override
//   Widget build(BuildContext context) {
//     return Text(getText());
//   }

//   String getText() {
//     return 'WidgetFoo';
//   }
// }

// class WidgetBar extends WidgetFoo {
//   @override
//   State<StatefulWidget> createState() => _WidgetBarState<WidgetBar>();
// }

// class _WidgetBarState extends WidgetFooState<WidgetBar> {
//   @override
//   String getText() {
//     return 'WidgetBar, ${varFromFooState}, ${widget.varFromFoo}';
//   }
// }