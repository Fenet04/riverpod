import 'package:flutter/material.dart';

void main() => runApp(const AdminApp());

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin - Pet Visit Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdminScreen(),
    );
  }
}

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Map<String, dynamic>> appointments = [
    {
      'petName': 'Charlie',
      'date': 'April 20, 2024',
      'time': '2 PM - 3 PM',
      'status': 'Pending',
      'serviceType': 'Store Visit',
      'applicantName': 'John Doe',
    },
    {
      'petName': 'Max',
      'date': 'April 22, 2024',
      'time': '11 AM - 12 PM',
      'status': 'Confirmed',
      'serviceType': 'Trial at Home',
      'applicantName': 'Jane Smith',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0,
        title: const Text(
          'Manage Appointments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (BuildContext context, int index) {
              var appointment = appointments[index];
              return Center(
                child: Container(
                  width: constraints.maxWidth > 600 ? 600 : constraints.maxWidth * 0.95,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey[100],
                        child: Icon(
                          appointment['serviceType'] == 'Store Visit' ? Icons.store : Icons.home,
                          color: Colors.orange,
                        ),
                      ),
                      title: Text('${appointment['applicantName']} - ${appointment['date']} - ${appointment['petName']}'),
                      subtitle: Text('${appointment['time']} - ${appointment['status']} - ${appointment['serviceType']}'),
                      trailing: _buildStatusIcon(appointment['status']),
                      onTap: () => _showAppointmentActions(context, appointment, index),
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    Color color;
    IconData icon;
    switch (status) {
      case 'Confirmed':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'Pending':
        color = Colors.orange;
        icon = Icons.hourglass_empty;
        break;
      case 'Declined':
        color = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        color = Colors.grey;
        icon = Icons.help_outline;
    }
    return Icon(icon, color: color);
  }

  void _showAppointmentActions(BuildContext context, Map<String, dynamic> appointment, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('Accept ${appointment['serviceType']}'),
              onTap: () {
                _updateAppointmentStatus(index, 'Confirmed');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel_outlined, color: Colors.red),
              title: Text('Decline ${appointment['serviceType']}'),
              onTap: () {
                _updateAppointmentStatus(index, 'Declined');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: Text('Reschedule ${appointment['serviceType']}'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _updateAppointmentStatus(int index, String newStatus) {
    setState(() {
      appointments[index]['status'] = newStatus;
    });
  }
}
