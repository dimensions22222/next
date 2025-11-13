// File: lib/pages/transaction_history_page.dart
// Usage: push or include TransactionHistoryPage() inside your DashboardPage
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TxStatus { successful, pending, failed, reversed, toBePaid }

class TransactionItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime date;
  final double amount;
  final TxStatus status;
  final String type; // e.g. Mobile Data, Airtime, Transfer
  final bool isCashback;
  final String? details; // details text
  final double? cashbackAmount;

  TransactionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.status,
    required this.type,
    this.isCashback = false,
    this.details,
    this.cashbackAmount,
  });
}

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  // Mock data (replace with real API)
  final List<TransactionItem> _allTransactions = List.generate(8, (i) {
    final date = DateTime.now().subtract(Duration(days: i * 2));
    return TransactionItem(
      id: 'tx_$i',
      title: (i % 3 == 0) ? 'Transfer from PEARL CRAIG' : (i % 3 == 1 ? 'Airtime' : 'Mobile Data'),
      subtitle: (i % 3 == 0) ? 'In: ₦2,521.00  Out: ₦1,700.00' : (i % 3 == 1 ? 'Airtime purchase' : 'Data bundle'),
      date: date,
      amount: (i % 2 == 0) ? -9000.0 : 8000.0,
      status: (i % 4 == 0) ? TxStatus.successful : (i % 4 == 1 ? TxStatus.pending : (i % 4 == 2 ? TxStatus.failed : TxStatus.reversed)),
      type: (i % 3 == 0) ? 'Transfer' : (i % 3 == 1 ? 'Airtime' : 'Mobile Data'),
      isCashback: i == 2,
      cashbackAmount: i == 2 ? 17.50 : null,
      details: 'Transaction details for item $i. Payment method: Wallet. Transaction No: 1234567890',
    );
  });

  // UI state
  String _selectedCategory = 'All Categories';
  String _selectedStatus = 'All Status';
  TxStatus? _filterStatus; // null = all
  List<String> categories = ['All Categories', 'Transfer to', 'Airtime', 'Mobile Data', 'Electricity', 'TV', 'Add Money'];

  // Pagination / search not required but can be added
  List<TransactionItem> get _filteredTransactions {
    var list = _allTransactions;
    if (_selectedCategory != 'All Categories') {
      list = list.where((t) => t.type == _selectedCategory || t.title.contains(_selectedCategory)).toList();
    }
    if (_filterStatus != null) {
      list = list.where((t) => t.status == _filterStatus).toList();
    }
    return list;
  }

  final currency = NumberFormat.currency(symbol: '₦', decimalDigits: 2);

  void _openTransactionDetails(TransactionItem item) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.86,
        child: TransactionDetailsSheet(item: item),
      ),
    );
  }

  void _openCashbackDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CashbackDetailsPage()),
    );
  }

  void _setStatusFilter(String statusLabel) {
    setState(() {
      _selectedStatus = statusLabel;
      switch (statusLabel) {
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

  Widget _buildFilterChips() {
    // Category chip row and status chip row
    final statusOptions = ['All Status', 'Successful', 'Pending', 'Failed', 'To be paid', 'Reversed'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: categories.map((c) {
            final bool selected = _selectedCategory == c;
            return ChoiceChip(
              labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              label: Text(c),
              selected: selected,
              onSelected: (_) {
                setState(() {
                  _selectedCategory = c;
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: statusOptions.map((s) {
              final bool selected = _selectedStatus == s;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: selected ? Theme.of(context).primaryColor : Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => _setStatusFilter(s),
                  child: Text(s),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionTile(TransactionItem t) {
    final statusLabel = {
      TxStatus.successful: 'Successful',
      TxStatus.pending: 'Pending',
      TxStatus.failed: 'Failed',
      TxStatus.reversed: 'Reversed',
      TxStatus.toBePaid: 'To be paid'
    }[t.status];

    final amountColor = t.amount < 0 ? Colors.red : Colors.green;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: const AssetImage('assets/placeholder.png'),
        backgroundColor: Colors.grey.shade200,
      ),
      title: Text(t.title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(DateFormat.yMMMd().add_jm().format(t.date), style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(currency.format(t.amount.abs()), style: TextStyle(color: amountColor, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: t.status == TxStatus.successful ? Colors.green.shade50 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              statusLabel ?? '',
              style: TextStyle(fontSize: 12, color: t.status == TxStatus.successful ? Colors.green.shade800 : Colors.grey.shade700),
            ),
          )
        ],
      ),
      onTap: () => _openTransactionDetails(t),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTransactions;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        actions: [
          TextButton(
            onPressed: () {
              // Download action placeholder
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Download clicked')));
            },
            child: const Text('Download', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            _buildFilterChips(),
            const SizedBox(height: 12),
            Expanded(
              child: filtered.isEmpty
                  ? _EmptyTransactionsView(onViewAnalysis: () {
                      // placeholder: show analysis
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('View Analysis')));
                    })
                  : ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final t = filtered[index];
                        return _buildTransactionTile(t);
                      },
                    ),
            ),
            const SizedBox(height: 8),
            // A small bottom action to open Cashback details — reflects screenshot navigation.
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.card_giftcard),
                  label: const Text('Cashback Details'),
                  onPressed: _openCashbackDetails,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'All Categories';
                      _selectedStatus = 'All Status';
                      _filterStatus = null;
                    });
                  },
                  child: const Text('Reset Filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state widget (mirrors empty screenshot)
class _EmptyTransactionsView extends StatelessWidget {
  final VoidCallback onViewAnalysis;
  const _EmptyTransactionsView({Key? key, required this.onViewAnalysis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final illustration = Image.asset(
      'assets/illustration_empty.png',
      width: 160,
      height: 160,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(Icons.receipt_long, size: 120, color: Colors.grey.shade300),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          illustration,
          const SizedBox(height: 18),
          Text('No transaction records found for the past 1 year', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onViewAnalysis,
            child: const Text('View Analysis'),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet that shows transaction details, bonus/cashback states, and actions.
class TransactionDetailsSheet extends StatelessWidget {
  final TransactionItem item;
  const TransactionDetailsSheet({Key? key, required this.item}) : super(key: key);

  Widget _topIndicator(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4))),
        const SizedBox(height: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = item.status == TxStatus.successful ? Colors.green : Colors.grey.shade700;
    final amountText = NumberFormat.currency(symbol: '₦', decimalDigits: 2).format(item.amount.abs());

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _topIndicator(context),
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: const AssetImage('assets/placeholder.png'),
                    backgroundColor: Colors.grey.shade100,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(item.type, style: TextStyle(color: Colors.grey.shade600)),
                    ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(amountText, style: TextStyle(fontSize: 18, color: item.amount < 0 ? Colors.red : Colors.green, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: statusColor, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            (item.status == TxStatus.successful) ? 'Successful' : item.status.toString().split('.').last,
                            style: TextStyle(color: statusColor),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 18),
              Text('Transaction Details', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey.shade800)),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: Colors.grey.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _detailRow('Recipient/Mobile', '070 3222 0889'),
                    const SizedBox(height: 8),
                    _detailRow('Data Bundle', '3.5gb + 5mins Monthly Plan'),
                    const SizedBox(height: 8),
                    _detailRow('Transaction Type', item.type),
                    const SizedBox(height: 8),
                    _detailRow('Payment Method', 'Wallet'),
                    const SizedBox(height: 8),
                    _detailRow('Transaction NO.', '123478901234789009874321'),
                    const SizedBox(height: 8),
                    _detailRow('Transaction Date', DateFormat.yMMMMd().add_jm().format(item.date)),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              if (item.isCashback && item.cashbackAmount != null) ...[
                Text('Bonus from Data Purchase', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey.shade800)),
                const SizedBox(height: 8),
                Card(
                  elevation: 0,
                  color: Colors.blue.shade50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const CircleAvatar(child: Icon(Icons.local_offer, color: Colors.white), backgroundColor: Colors.blue),
                        const SizedBox(width: 12),
                        Expanded(child: Text('₦${item.cashbackAmount!.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold))),
                        Text('Successful', style: TextStyle(color: Colors.green.shade700)),
                      ],
                    ),
                  ),
                ),
              ],
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report Issue clicked')));
                      },
                      child: const Text('Report Issue'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // share receipt action
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Share Receipt')));
                      },
                      child: const Text('Share Receipt'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade700))),
      Expanded(flex: 5, child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
    ]);
  }
}

/// Cashback details page (mirrors the rightmost screenshots)
class CashbackDetailsPage extends StatefulWidget {
  const CashbackDetailsPage({Key? key}) : super(key: key);

  @override
  State<CashbackDetailsPage> createState() => _CashbackDetailsPageState();
}

class _CashbackDetailsPageState extends State<CashbackDetailsPage> {
  double totalCashback = 21.0;
  final List<Map<String, dynamic>> records = [
    {'title': 'Bonus from Airtime Purchase', 'date': DateTime.now().subtract(const Duration(days: 50)), 'amount': 17.5},
    {'title': 'Bonus from Airtime Purchase', 'date': DateTime.now().subtract(const Duration(days: 55)), 'amount': 17.5},
  ];

  bool showEarnings = true; // toggle Earnings / Expenses
  String timeFilter = 'This month'; // 'This year' etc

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '₦', decimalDigits: 2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashback Details'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              height: 86,
              decoration: BoxDecoration(color: Colors.blue.shade700, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                child: Row(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Cashback', style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 6),
                      Text(currency.format(totalCashback), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ]),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.blue),
                      onPressed: () {
                        // how to use
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('How to use cashback')));
                      },
                      child: const Text('How to use'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Earnings & Expenses', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Row(children: [
                    Expanded(child: Text('Earnings this month\n₦21.00', style: const TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text('Earnings this year\n₦21.00', style: const TextStyle(fontWeight: FontWeight.bold))),
                  ]),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ChoiceChip(label: const Text('All'), selected: true, onSelected: (_) {}),
                      const SizedBox(width: 8),
                      ChoiceChip(label: const Text('Earnings'), selected: showEarnings, onSelected: (_) {
                        setState(() {
                          showEarnings = true;
                        });
                      }),
                      const SizedBox(width: 8),
                      ChoiceChip(label: const Text('Expenses'), selected: !showEarnings, onSelected: (_) {
                        setState(() {
                          showEarnings = false;
                        });
                      }),
                    ],
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: records.isEmpty
                  ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text('No record found for the last 7 months'),
                    ]))
                  : ListView.separated(
                      itemCount: records.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final r = records[index];
                        return ListTile(
                          leading: CircleAvatar(child: const Icon(Icons.local_offer), backgroundColor: Colors.blue.shade100),
                          title: Text(r['title']),
                          subtitle: Text(DateFormat.yMMMd().format(r['date'])),
                          trailing: Text('+${currency.format(r['amount'])}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
