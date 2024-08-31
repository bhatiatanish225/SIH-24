import 'package:attendease/attendance_log.dart';
import 'package:attendease/landing.dart';
import 'package:attendease/landing_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const EmployeeDashboard(),
    );
  }
}

class EmployeeDashboard extends StatelessWidget {
  const EmployeeDashboard({Key? key}) : super(key: key);

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning Tanish Bhatia';
    } else if (hour < 15) {
      return 'Good Afternoon Tanish Bhatia';
    } else {
      return 'Good Evening Tanish Bhatia';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DASHBOARD'),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.teal,
              ),
              accountName: const Text(
                'Tanish Bhatia',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              accountEmail: const Text(
                'Current Location: Thapar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.teal,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                // Handle Setting option
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: const Text('Contact Admin'),
              onTap: () {
                // Handle Contact Admin option
              },
            ),
            ListTile(
              leading: Icon(Icons.upload_file),
              title: const Text('Upload Task'),
              onTap: () {
                // Handle Upload Task option
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                // Handle Edit Profile option
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: const Text('Notifications and Notices'),
              onTap: () {
                // Handle Notifications and Notices option
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                // Handle Logout option
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.orangeAccent,
              child: ListTile(
                title: Text(
                  _getGreetingMessage(), // Dynamic greeting message
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'EMPLOYEE ID : 12345',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'tbhatia0225@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.blueAccent,
              child: ListTile(
                title: const Text(
                  'ALLOCATED LOCATION',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Thapar, Patiala',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>( LandingPage1())));
                       
                  },
                  child: const Text('Manual Check in'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Card(
                    color: Colors.orangeAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Time Remaining 30:00',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceLogPage()));
                    },
                    icon: Icon(Icons.access_time),
                    label: const Text('ATTENDANCE LOG'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.history),
                    label: const Text('PREVIOUS RECORDS'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.assignment),
                    label: const Text('LEAVE APPLICATION'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.check),
                    label: const Text('LEAVE STATUS'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.calendar_today),
            ),
            CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              radius: 20,
              child: Text(
                'AE',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
