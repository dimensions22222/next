// transaction_history_page.dart
// ignore_for_file: unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next/Features/transactions/Modelz/transaction_item.dart';
import 'transaction_details_sheet.dart';
import 'cashback_details_page.dart';
import 'widgets/transaction_tile.dart';
import 'widgets/empty_state_view.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  late final List<TransactionItem> _allTransactions;
  String _selectedCategory = 'All Categories';
  String _selectedStatus = 'All Status';
  TxStatus? _filterStatus;

  // month selector for the top summary. Default matches the Figma screenshot.
  final List<String> _months = const [
    'Aug',
    'Jul',
    'Jun',
    'May',
    'Apr',
    'Mar',
    'Feb',
    'Jan'
  ];
  String _selectedMonth = 'Aug';

  final categories = [
    'All Categories',
    'Transfer from',
    'Transfer to',
    'Airtime',
    'Mobile Data',
    'Electricity',
    'TV',
    'Add Money'
  ];

  final statusOptions = [
    'All Status',
    'Successful',
    'Pending',
    'Failed',
    'To be paid',
    'Reversed'
  ];

  @override
  void initState() {
    super.initState();
    _allTransactions = List.generate(8, (i) {
      final date = DateTime.now().subtract(Duration(days: i * 2));
      return TransactionItem(
        id: 'tx_$i',
        title: (i % 3 == 0)
            ? 'Transfer from PEARL CRAIG'
            : (i % 3 == 1 ? 'Airtime' : 'Mobile Data'),
        subtitle: (i % 3 == 0)
            ? 'In: ₦2,521.00  Out: ₦1,700.00'
            : (i % 3 == 1 ? 'Airtime purchase' : 'Data bundle'),
        date: date,
        amount: (i % 2 == 0) ? -9000.0 : 8000.0,
        status: (i % 4 == 0)
            ? TxStatus.successful
            : (i % 4 == 1
                ? TxStatus.pending
                : (i % 4 == 2 ? TxStatus.failed : TxStatus.reversed)),
        type: (i % 3 == 0)
            ? 'Transfer'
            : (i % 3 == 1 ? 'Airtime' : 'Mobile Data'),
        isCashback: i == 2,
        cashbackAmount: i == 2 ? 17.50 : null,
        transactionNo: '1234789012347890098743$i',
        paymentMethod: 'Wallet',
      );
    });
  }

  List<TransactionItem> get _filteredTransactions {
    var list = _allTransactions;
    if (_selectedCategory != 'All Categories') {
      list = list
          .where((t) =>
              t.type == _selectedCategory || t.title.contains(_selectedCategory))
          .toList();
    }
    if (_filterStatus != null) {
      list = list.where((t) => t.status == _filterStatus).toList();
    }
    return list;
  }

  void _setStatusFilter(String s) {
    setState(() {
      _selectedStatus = s;
      switch (s) {
        case 'Successful':
          _filterStatus = TxStatus.successful;
          break;
        case 'Pending':
          _filterStatus = TxStatus.pending;
          break;
        case 'Failed':
          _filterStatus = TxStatus.failed;
          break;
        case 'Reversed':
          _filterStatus = TxStatus.reversed;
          break;
        case 'To be paid':
          _filterStatus = TxStatus.toBePaid;
          break;
        default:
          _filterStatus = null;
      }
    });
  }

  void _openTransactionDetails(TransactionItem item) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(247, 255, 255, 255),
      context: context,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.86,
        child: TransactionDetailsSheet(item: item),
      ),
    );
  }

  void _openCashbackDetails() => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const CashbackDetailsPage()),
      );

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTransactions;
    const mainBlue = Color(0xFF0D47A1);

    Widget buildTopSummary() {
      // These numbers are set to match the Figma screenshot exactly.
      const inAmount = '₦2,521.00';
      const outAmount = '₦1,700.00';

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // Month selector (left)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedMonth,
                      items: _months
                          .map((m) => DropdownMenuItem(
                                value: m,
                                child: Text(m,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedMonth = val);
                        }
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: Colors.black54,
                      ),
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // In / Out column (center)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('In  $inAmount',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('Out $outAmount',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.grey.shade600)),
                ],
              ),
            ),

            // Analysis button (right)
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Analysis clicked')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainBlue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: const Text('Analysis',
                  style: TextStyle(fontWeight: FontWeight.w600,color: Color.from(alpha: 1, red: 1, green: 1, blue: 1))),
            ),
          ],
        ),
      );
    }

    Widget buildDropdowns() => Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color.fromARGB(255, 13, 71, 161)
                          .withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: mainBlue.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    items: categories
                        .map((cat) => DropdownMenuItem<String>(
                              value: cat,
                              child: Text(cat,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedCategory = value);
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color.fromARGB(255, 13, 71, 161)
                          .withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: mainBlue.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedStatus,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    items: statusOptions
                        .map((s) => DropdownMenuItem<String>(
                              value: s,
                              child: Text(s,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) _setStatusFilter(value);
                    },
                  ),
                ),
              ),
            ),
          ],
        );

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Center(
          child: Text('Transactions',
              style: TextStyle(fontWeight: FontWeight.w700)),
        ),
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Downloading...'))),
            child: const Text('Download',
                style: TextStyle(color: mainBlue)),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 800;

            if (isTablet) {
              // Tablet layout: left column with list & filters, right column preview
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Filters row
                        buildDropdowns(),
                        const SizedBox(height: 12),
                        // Top summary exactly like the figma
                        buildTopSummary(),
                        const SizedBox(height: 12),

                        Expanded(
                          child: filtered.isEmpty
                              ? EmptyStateView(
                                  onPrimary: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text('View Analysis'))))
                              : ListView.separated(
                                  itemCount: filtered.length,
                                  separatorBuilder: (_, __) =>
                                      const Divider(height: 1),
                                  itemBuilder: (context, index) {
                                    final t = filtered[index];
                                    return TransactionTile(
                                        item: t,
                                        onTap: () => _openTransactionDetails(t));
                                  },
                                ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.card_giftcard),
                              label: const Text('Cashback Details'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _openCashbackDetails,
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () => setState(() {
                                _selectedCategory = 'All Categories';
                                _selectedStatus = 'All Status';
                                _filterStatus = null;
                              }),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: mainBlue),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text('Reset Filters',
                                  style: TextStyle(color: mainBlue)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Select a transaction to view details',
                                  style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 120,
                                child: Image.asset('assets/placeholder.png',
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.receipt_long, size: 80)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              // Mobile layout: stacked
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildDropdowns(),
                  const SizedBox(height: 12),
                  buildTopSummary(),
                  const SizedBox(height: 9),
                  Expanded(
                    child: filtered.isEmpty
                        ? EmptyStateView(
                            onPrimary: () => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text('View Analysis'))))
                        : ListView.separated(
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final t = filtered[index];
                              return TransactionTile(
                                  item: t,
                                  onTap: () => _openTransactionDetails(t));
                            },
                          ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.card_giftcard),
                        label: const Text('Cashback Details',),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainBlue,
                          foregroundColor: const Color.fromARGB(255, 247, 250, 255),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _openCashbackDetails,
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () => setState(() {
                          _selectedCategory = 'All Categories';
                          _selectedStatus = 'All Status';
                          _filterStatus = null;
                        }),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: mainBlue),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Reset Filters',
                            style: TextStyle(color: mainBlue)),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
