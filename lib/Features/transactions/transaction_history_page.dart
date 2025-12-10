// transaction_history_page.dart
// ignore_for_file: unused_import, deprecated_member_use, unused_local_variable

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

  bool _showCategoryDropdown = false;
  bool _showStatusDropdown = false;

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
    'USSD Charge',
    'Transfer from',
    'Transfer to',
    'Airtime',
    'Mobile Data',
    'Add Money',
    'Electricity',
    'TV'
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

    // ★★★★★ NEW IMPRESSIVE MONTH DROPDOWN ★★★★★
    Widget buildTopSummary() {
      const inAmount = '₦2,521.00';
      const outAmount = '₦1,700.00';

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            // ★ PREMIUM MONTH DROPDOWN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
                
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedMonth,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 28,
                    color: Colors.black54,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  items: _months
                      .map(
                        (m) => DropdownMenuItem(
                          value: m,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                                color: mainBlue,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                m,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedMonth = val);
                    }
                  },
                ),
              ),
            ),

            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'In  ₦5,521.00',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Out ₦1,700.00',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Analysis clicked')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainBlue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: const Text(
                'Analysis',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END OF MONTH SUMMARY UI CHANGE — NOTHING ELSE TOUCHED

    Widget buildDropdowns() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showCategoryDropdown = !_showCategoryDropdown;
                      _showStatusDropdown = false;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: _showCategoryDropdown
                          ? const Color(0xFFE8F0FE)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: mainBlue),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedCategory,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: mainBlue,
                          ),
                        ),
                        Icon(
                          _showCategoryDropdown
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: mainBlue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showStatusDropdown = !_showStatusDropdown;
                      _showCategoryDropdown = false;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: _showStatusDropdown
                          ? Colors.black.withOpacity(0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedStatus,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(
                          _showStatusDropdown
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (_showCategoryDropdown)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: categories.map((c) {
                final selected = _selectedCategory == c;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = c;
                      _showCategoryDropdown = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? mainBlue.withOpacity(0.12)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? mainBlue
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      c,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected ? mainBlue : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

          if (_showStatusDropdown)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: statusOptions.map((s) {
                final selected = _selectedStatus == s;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStatus = s;
                      _setStatusFilter(s);
                      _showStatusDropdown = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.black.withOpacity(0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? Colors.black
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      s,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.black : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      );
    }

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
            child:
                const Text('Download', style: TextStyle(color: mainBlue)),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 800;

            if (isTablet) {
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        buildDropdowns(),
                        const SizedBox(height: 13),
                        buildTopSummary(),
                        const SizedBox(height: 13),
                        Expanded(
                          child: filtered.isEmpty
                              ? EmptyStateView(
                                  onPrimary: () =>
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('View Analysis'))))
                              : ListView.separated(
                                  itemCount: filtered.length,
                                  separatorBuilder: (_, __) =>
                                      const Divider(height: 1),
                                  itemBuilder: (context, index) {
                                    final t = filtered[index];
                                    return TransactionTile(
                                      item: t,
                                      onTap: () => _openTransactionDetails(t),
                                    );
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 120,
                                child: Image.asset(
                                  'assets/placeholder.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.receipt_long, size: 80),
                                ),
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
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final t = filtered[index];
                              return TransactionTile(
                                item: t,
                                onTap: () => _openTransactionDetails(t),
                              );
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
                          foregroundColor:
                              const Color.fromARGB(255, 247, 250, 255),
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
