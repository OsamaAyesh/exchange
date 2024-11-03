import 'package:exchange/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/get_transaction_by_id_box.dart';
import '../../domain/use_cases/get_transactions.dart';

class FilterTransactionsScreen extends StatefulWidget {
  final int idBox;
  final String nameBox;

  FilterTransactionsScreen({required this.idBox, required this.nameBox});

  @override
  _FilterTransactionsScreenState createState() =>
      _FilterTransactionsScreenState();
}

class _FilterTransactionsScreenState extends State<FilterTransactionsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? startDate;
  String? endDate;
  String? sourceId;
  String? search;
  String? type;
  List<TransactionDataByIdBox> filteredTransactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  final GetTransactions getTransactions = GetTransactions();

  Future<void> _fetchFilteredTransactions() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null; // Reset error message
      });

      try {
        List<TransactionDataByIdBox> transactions =
            await getTransactions.fetchTransactions(
          widget.idBox,
          startDate: "01-7-2023",
          endDate: "03-10-2024",
          sourceId: sourceId,
          search: search,
          type: type,
        );
        print(transactions);

        setState(() {
          filteredTransactions = transactions;
        });
      } catch (error) {
        setState(() {
          _errorMessage = error.toString(); // Capture error message
        });
      } finally {
        setState(() {
          _isLoading = false; // Stop loading state
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
            ),
          ),
        ],
        title: Text(
          widget.nameBox,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _fetchFilteredTransactions();
                  },
                  child: Text("data"))
              // SizedBox(height: 20),
              // if (_errorMessage != null)
              //   Text(
              //     _errorMessage!,
              //     style: TextStyle(color: Colors.red),
              //   ),
              // if (filteredTransactions != null && filteredTransactions!.isNotEmpty)
              //   Expanded(
              //     child: ListView.builder(
              //       itemCount: filteredTransactions!.length,
              //       itemBuilder: (context, index) {
              //         var transaction = filteredTransactions![index];
              //         return ListTile(
              //           title: Text(transaction.serviceName ?? 'No Service'),
              //           subtitle: Text('Amount: ${transaction.amount ?? '0'}'),
              //         );
              //       },
              //     ),
              //   )
              // else if (filteredTransactions != null && filteredTransactions!.isEmpty)
              //   Text('No transactions found.'),
            ],
          ),
        ),
      ),
    );
  }
}
