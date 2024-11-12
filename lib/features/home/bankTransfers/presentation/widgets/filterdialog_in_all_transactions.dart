import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../manager/filterd_or_not.dart';

class FilterDialog extends StatefulWidget {
  final Function(String?, String?, String?, String?, String?) onApply;

  const FilterDialog({Key? key, required this.onApply}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? startDate;
  String? endDate;
  String? search;
  String? accountId;
  String? userId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filter Transactions"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Add input fields for start date, end date, search, account ID, and user ID
            TextField(
              decoration: InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
              onChanged: (value) => startDate = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
              onChanged: (value) => endDate = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Search'),
              onChanged: (value) => search = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Account ID'),
              onChanged: (value) => accountId = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'User ID'),
              onChanged: (value) => userId = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onApply(startDate, endDate, search, accountId, userId);
            Provider.of<FilterdOrNot>(context, listen: false)
                .newValueIsFilter = true;
            Navigator.of(context).pop();
          },
          child: Text('Apply'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
