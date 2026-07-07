import 'package:flutter/material.dart';

import '../../models/dashboard.dart';
import '../../models/recent_activity.dart';
import '../../services/dashboard_service.dart';

import '../../widgets/dashboard_header.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profit_card.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/recent_activity_card.dart';
import '../../widgets/section_title.dart';
import '../../widgets/stat_card.dart';

import '../crop/crop_list_screen.dart';
import '../expense/expense_list_screen.dart';
import '../harvest/harvest_list_screen.dart';
import '../labour/labour_list_screen.dart';
import '../payment/payment_list_screen.dart';
import '../work_entry/work_entry_list_screen.dart';
import '../inventory/inventory_list_screen.dart';


class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();

}

class _DashboardScreenState
    extends State<DashboardScreen> {

  final DashboardService dashboardService =
      DashboardService();

  Dashboard? dashboard;
  List<RecentActivity> recentActivities = [];

  bool loading = true;

  @override
  void initState() {

    super.initState();

    loadDashboard();

  }

  Future<void> loadDashboard() async {

  try {

    final results = await Future.wait([

      dashboardService.getDashboard(),

      dashboardService.getRecentActivities(),

    ]);

    dashboard = results[0] as Dashboard;

    recentActivities =
        results[1] as List<RecentActivity>;

  } catch (e) {

    if (mounted) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),

        ),

      );

    }

  }

  if (mounted) {

    setState(() {

      loading = false;

    });

  }

}

  Future<void> openPage(Widget page) async {

    await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => page,

      ),

    );

    loadDashboard();

  }

  Widget statisticsGrid() {

    return GridView(

      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      gridDelegate:

          const SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: 2,

        mainAxisSpacing: 15,

        crossAxisSpacing: 15,

        childAspectRatio: 1.2,

      ),

      children: [

        StatCard(

          title: "Labours",

          value: dashboard!.totalLabours.toString(),

          icon: Icons.people,

          color: Colors.blue,

        ),

        StatCard(

          title: "Crops",

          value: dashboard!.totalCrops.toString(),

          icon: Icons.grass,

          color: Colors.green,

        ),

        StatCard(

          title: "Harvest",

          value: dashboard!.totalHarvests.toString(),

          icon: Icons.agriculture,

          color: Colors.orange,

        ),

        StatCard(

          title: "Work Entries",

          value:
              dashboard!.totalWorkEntries.toString(),

          icon: Icons.work,

          color: Colors.purple,

        ),

      ],

    );

  }

  Widget quickActions() {

    return Wrap(

      spacing: 25,

      runSpacing: 20,

      children: [

        QuickActionButton(

          icon: Icons.people,

          title: "Labour",

          onTap: () {

            openPage(

              const LabourListScreen(),

            );

          },

        ),

        QuickActionButton(

          icon: Icons.work,

          title: "Work",

          onTap: () {

            openPage(

              const WorkEntryListScreen(),

            );

          },

        ),

        QuickActionButton(

          icon: Icons.money,

          title: "Expense",

          onTap: () {

            openPage(

              const ExpenseListScreen(),

            );

          },

        ),

        QuickActionButton(

          icon: Icons.grass,

          title: "Crop",

          onTap: () {

            openPage(

              const CropListScreen(),

            );

          },

        ),

        QuickActionButton(

          icon: Icons.agriculture,

          title: "Harvest",

          onTap: () {

            openPage(

              const HarvestListScreen(),

            );

          },

        ),

        QuickActionButton(

          icon: Icons.payments,

          title: "Payment",

          onTap: () {

            openPage(

              const PaymentListScreen(),

            );

          },

        ),
        QuickActionButton(

  title: "Inventory",

  icon: Icons.inventory_2,

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const InventoryListScreen(),

      ),

    );

  },

),


      ],

    );

  }
    @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Scaffold(

        body: LoadingWidget(),

      );

    }

    return Scaffold(

      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(

        title: const Text("Dashboard"),

        centerTitle: true,

        elevation: 0,

      ),

      body: RefreshIndicator(

        onRefresh: loadDashboard,

        child: SingleChildScrollView(

          physics:
              const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.all(16),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const DashboardHeader(),

              const SizedBox(height: 20),

              ProfitCard(

                revenue:
                    dashboard!.totalRevenue,

                expense:
                    dashboard!.totalExpenses,

                profit:
                    dashboard!.netProfit,

              ),

              const SizedBox(height: 25),

              const SectionTitle(
                title: "Statistics",
              ),

              statisticsGrid(),

              const SizedBox(height: 25),

              const SectionTitle(
                title: "Quick Actions",
              ),

              quickActions(),

              const SizedBox(height: 25),

              const SectionTitle(
  title: "Recent Activity",
),

Column(

  children: recentActivities.map((activity) {

    IconData icon;

    switch (activity.type) {

      case "HARVEST":
        icon = Icons.agriculture;
        break;

      case "EXPENSE":
        icon = Icons.money;
        break;

      case "PAYMENT":
        icon = Icons.payments;
        break;

      default:
        icon = Icons.info;
    }

    return RecentActivityCard(

      icon: icon,

      title: activity.title,

      subtitle: activity.subtitle,

      amount: "₹${activity.amount.toStringAsFixed(0)}",

    );

  }).toList(),

),

              const SizedBox(height: 25),

              const SectionTitle(
                title: "Coming Soon",
              ),

              Card(

                child: Padding(

                  padding:
                      const EdgeInsets.all(20),

                  child: Row(

                    children: [

                      const Icon(

                        Icons.bar_chart,

                        size: 40,

                        color: Colors.green,

                      ),

                      const SizedBox(width: 20),

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: const [

                            Text(

                              "Analytics Dashboard",

                              style: TextStyle(

                                fontSize: 18,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),

                            SizedBox(height: 8),

                            Text(

                              "Revenue vs Expense charts, Crop analytics and Monthly reports will appear here.",

                            ),

                          ],

                        ),

                      ),

                    ],

                  ),

                ),

              ),

              const SizedBox(height: 40),

            ],

          ),

        ),

      ),

    );

  }

}