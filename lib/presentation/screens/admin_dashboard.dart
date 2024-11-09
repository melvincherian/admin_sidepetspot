// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:petspot_admin_side/presentation/screens/add_category.dart';
import 'package:petspot_admin_side/presentation/screens/category_list.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/add_product.dart';
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
        return [
          FlSpot(0, 2),
          FlSpot(1, 3),
          FlSpot(2, 5),
          FlSpot(3, 3),
          FlSpot(4, 4),
          FlSpot(5, 6),
          FlSpot(6, 5),
        ];
      case 'Monthly':
        return [
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
        return [
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
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Admin menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('User Management'),
              onTap: () {},
            ),
             ListTile(
              leading: Icon(Icons.person),
              title: const Text('Category List'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.chat_rounded),
              title: const Text('Sales Report'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: const Text('Product Management'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: const Text('Category Management'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCategory()));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.category),
            //   title: const Text('product list'),
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPetDetail(product: product)));
            //   },
            // ),
            
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Revenue Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildViewButton('Today'),
                _buildViewButton('Weekly'),
                _buildViewButton('Monthly'),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
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
                      // colors: [Colors.teal],
                      belowBarData: BarAreaData(
                        show: true,
                        // colors: [Colors.teal.withOpacity(0.3)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: cardTitles.length,
                itemBuilder: (BuildContext context, int index) {
                  return _card(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Button widget for selecting view
  Widget _buildViewButton(String view) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedView = view;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedView == view ? Colors.teal : Colors.grey[300],
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

  Widget _card(int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            cardTitles[index],
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
