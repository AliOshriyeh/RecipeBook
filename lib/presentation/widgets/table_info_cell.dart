import 'package:flutter/material.dart';

class TableInfoCell {
  final String title;
  final String value;

  const TableInfoCell(
    this.title,
    this.value,
  );

  TableRow get display => TableRow(children: [Container(padding: const EdgeInsets.all(5), child: Text("$title: $value"))]);
}
