library auto_fit_data_table;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AutoFitDataTable extends StatefulWidget {
  final DataTableSource source;
  final List<DataColumn> columns;
  final Widget? header;
  final List<Widget>? actions;
  final int? sortColumnIndex;
  final bool sortAscending;
  final void Function(bool?)? onSelectAll;
  final double dataRowHeight;
  final double headingRowHeight;
  final double horizontalMargin;
  final double columnSpacing;
  final bool showCheckboxColumn;
  final bool showFirstLastButtons;
  final int initialFirstRowIndex;
  final void Function(int)? onPageChanged;
  final ValueChanged<int?>? onRowsPerPageChanged;
  final DragStartBehavior dragStartBehavior;
  final Color? arrowHeadColor;
  final double? checkboxHorizontalMargin;

  const AutoFitDataTable({
    Key? key,
    this.header,
    this.actions,
    required this.columns,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    this.dataRowHeight = kMinInteractiveDimension,
    this.headingRowHeight = 56.0,
    this.horizontalMargin = 24.0,
    this.columnSpacing = 56.0,
    this.showCheckboxColumn = true,
    this.showFirstLastButtons = false,
    this.initialFirstRowIndex = 0,
    this.onPageChanged,
    this.onRowsPerPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    this.arrowHeadColor,
    required this.source,
    this.checkboxHorizontalMargin,
  }) : super(key: key);

  @override
  State<AutoFitDataTable> createState() => _AutoFitDataTableState();
}

class _AutoFitDataTableState extends State<AutoFitDataTable> with WindowListener {
  int _rowsPerPage = 15;
  Size? previousSize;

  @override
  void onWindowResize() {
    var size = context.size;
    if (size != null) {
      var newRowsPerPage =
          size.height ~/ widget.dataRowHeight - (3 * (widget.headingRowHeight ~/ widget.dataRowHeight) + 0);
      if (newRowsPerPage != _rowsPerPage && newRowsPerPage > 3) {
        setState(() {
          _rowsPerPage = newRowsPerPage;
        });
      }
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, onWindowResize);

    if (!windowManager.listeners.contains(this)) {
      windowManager.addListener(this);
    }

    return Expanded(
        child: SingleChildScrollView(
            child: PaginatedDataTable(
              header: widget.header,
              actions: widget.actions,
              columns: widget.columns,
              sortColumnIndex: widget.sortColumnIndex,
              sortAscending: widget.sortAscending,
              onSelectAll: widget.onSelectAll,
              dataRowHeight: widget.dataRowHeight,
              headingRowHeight: widget.headingRowHeight,
              horizontalMargin: widget.horizontalMargin,
              columnSpacing: widget.columnSpacing,
              showCheckboxColumn: widget.showCheckboxColumn,
              showFirstLastButtons: widget.showFirstLastButtons,
              initialFirstRowIndex: widget.initialFirstRowIndex,
              onPageChanged: widget.onPageChanged,
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: widget.onRowsPerPageChanged,
              dragStartBehavior: widget.dragStartBehavior,
              arrowHeadColor: widget.arrowHeadColor,
              source: widget.source,
              checkboxHorizontalMargin: widget.checkboxHorizontalMargin,
            )));
  }
}

