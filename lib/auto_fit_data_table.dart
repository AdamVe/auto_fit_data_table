library auto_fit_data_table;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AutoFitDataTable extends StatefulWidget {
  final DataTableSource source;
  final List<DataColumn> columns;
  final Widget? header;
  final List<Widget>? actions;
  final int? sortColumnIndex;
  final bool sortAscending;
  final void Function(bool?)? onSelectAll;
  final double dataRowMinHeight;
  final double dataRowMaxHeight;
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
    super.key,
    this.header,
    this.actions,
    required this.columns,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    this.dataRowMinHeight = kMinInteractiveDimension,
    this.dataRowMaxHeight = kMinInteractiveDimension,
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
  });

  @override
  State<AutoFitDataTable> createState() => _AutoFitDataTableState();
}

class _AutoFitDataTableState extends State<AutoFitDataTable> {
  Size? previousSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        final availableHeight = boxConstraints.maxHeight -
            (widget.header != null ? 64.0 : 0) -
            widget.headingRowHeight -
            (widget.showFirstLastButtons ? 64.0 : 0);

        var rowsPerPage = availableHeight ~/ widget.dataRowMaxHeight;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PaginatedDataTable(
                header: widget.header,
                actions: widget.actions,
                columns: widget.columns,
                sortColumnIndex: widget.sortColumnIndex,
                sortAscending: widget.sortAscending,
                onSelectAll: widget.onSelectAll,
                dataRowMinHeight: widget.dataRowMinHeight,
                dataRowMaxHeight: widget.dataRowMaxHeight,
                headingRowHeight: widget.headingRowHeight,
                horizontalMargin: widget.horizontalMargin,
                columnSpacing: widget.columnSpacing,
                showCheckboxColumn: widget.showCheckboxColumn,
                showFirstLastButtons: widget.showFirstLastButtons,
                initialFirstRowIndex: widget.initialFirstRowIndex,
                onPageChanged: widget.onPageChanged,
                rowsPerPage: rowsPerPage > 3 ? rowsPerPage : 3,
                onRowsPerPageChanged: widget.onRowsPerPageChanged,
                dragStartBehavior: widget.dragStartBehavior,
                arrowHeadColor: widget.arrowHeadColor,
                source: widget.source,
                checkboxHorizontalMargin: widget.checkboxHorizontalMargin,
              ),
            ],
          ),
        );
      },
    );
  }
}
