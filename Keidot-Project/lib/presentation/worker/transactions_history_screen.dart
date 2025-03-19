import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class TransactionsHistoryScreen extends StatelessWidget {
  const TransactionsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Lista de transacciones de ejemplo
    final List<Transaction> transactions = [
      Transaction(
          amount: 500.0,
          description: "Pago recibido",
          date: DateTime.now(),
          isIncome: true),
      Transaction(
          amount: 200.0,
          description: "Compra de insumos",
          date: DateTime.now().subtract(const Duration(days: 1)),
          isIncome: false),
      Transaction(
          amount: 1500.0,
          description: "Pago de cliente",
          date: DateTime.now().subtract(const Duration(days: 2)),
          isIncome: true),
      Transaction(
          amount: 100.0,
          description: "Mantenimiento",
          date: DateTime.now().subtract(const Duration(days: 3)),
          isIncome: false),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Historial de transacciones',
        backgroundColor: colors.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return _TransactionTile(transaction: transaction);
          },
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final sizeW = MediaQuery.of(context).size.width;

    return Card(
      color: colors.onPrimary,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaction.isIncome ? greenHigh : Colors.red,
          child: Icon(
            transaction.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: Colors.white,
          ),
        ),
        title: Text(
          transaction.description,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          DateFormat('dd MMM yyyy, hh:mm a').format(transaction.date),
          style: TextStyle(color: colors.primary),
        ),
        trailing: Text(
          '\$${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: sizeW * 0.045,
            fontWeight: FontWeight.bold,
            color: transaction.isIncome ? greenHigh : Colors.red,
          ),
        ),
      ),
    );
  }
}

class Transaction {
  final double amount;
  final String description;
  final DateTime date;
  final bool isIncome;

  Transaction({
    required this.amount,
    required this.description,
    required this.date,
    required this.isIncome,
  });
}
