// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:petspot_admin_side/presentation/screens/category_view.dart';
import 'package:petspot_admin_side/presentation/screens/details/user_list.dart';
import 'package:petspot_admin_side/presentation/screens/my_order.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/product_view.dart';
// import 'package:petspot_admin_side/presentation/screens/category_management.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<String> cardTitles = [
    'Total Products',
    'Total Orders',
    'Total Users',
    'Revenue',
  ];

  String selectedView = 'Today';

  // Sample data for different views
  List<FlSpot> getChartData() {
    switch (selectedView) {
      case 'Weekly':
        return const [
          FlSpot(0, 2),
          FlSpot(1, 3),
          FlSpot(2, 5),
          FlSpot(3, 3),
          FlSpot(4, 4),
          FlSpot(5, 6),
          FlSpot(6, 5),
        ];
      case 'Monthly':
        return const [
          FlSpot(0, 3),
          FlSpot(5, 4),
          FlSpot(10, 5),
          FlSpot(15, 3),
          FlSpot(20, 7),
          FlSpot(25, 6),
          FlSpot(30, 8),
        ];
      case 'Today':
      default:
        return const [
          FlSpot(0, 4),
          FlSpot(1, 3),
          FlSpot(2, 5),
          FlSpot(3, 2),
          FlSpot(4, 4),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Admin menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('User Management'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserList()));
              },
            ),

            // ListTile(
            //   leading:const Icon(Icons.chat_rounded),
            //   title: const Text('Sales Report'),
            //   onTap: () {},
            // ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Product Management'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductView()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Category Management'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryView()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping),
              title: const Text('Order management'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyOrders()));
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('payment').snapshots(),
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (orderSnapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          final orderCount = orderSnapshot.data?.docs.length ?? 0;

          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (userSnapshot.hasError) {
                return const Center(child: Text('Error loading data'));
              }

              final userCount = userSnapshot.data?.docs.length ?? 0;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Revenue Overview',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildViewButton('Today'),
                        _buildViewButton('Weekly'),
                        _buildViewButton('Monthly'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: const FlTitlesData(show: true),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          minX: 0,
                          maxX: selectedView == 'Monthly' ? 30 : 6,
                          minY: 0,
                          maxY: 8,
                          lineBarsData: [
                            LineChartBarData(
                              spots: getChartData(),
                              isCurved: true,
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: cardTitles.length,
                        itemBuilder: (BuildContext context, int index) {
                          String countDisplay = '';
                          if (index == 1) {
                            countDisplay = '$orderCount';
                          } else if (index == 2) {
                            countDisplay = '$userCount';
                          } else {
                            countDisplay = '';
                          }
                          return _card(cardTitles[index], countDisplay);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildViewButton(String view) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedView = view;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedView == view ? Colors.teal : Colors.grey[300],
        ),
        child: Text(
          view,
          style: TextStyle(
            color: selectedView == view ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Widget _card(int index) {
  //   return Card(
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(9),
  //     ),
  //     child: Padding(
  //       padding:const EdgeInsets.all(16.0),
  //       child: Center(
  //         child: Text(
  //           cardTitles[index],
  //           style:const TextStyle(fontSize: 18),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _card(String title, String count) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
