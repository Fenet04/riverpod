import 'package:flutter/material.dart';

void main() => runApp(UserApp());

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Adoption - User',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserAppointmentsScreen(),
    );
  }
}

class UserAppointmentsScreen extends StatefulWidget {
  @override
  _UserAppointmentsScreenState createState() => _UserAppointmentsScreenState();
}

class _UserAppointmentsScreenState extends State<UserAppointmentsScreen> {
  List<Map<String, dynamic>> appointments = [
    {
      'date': 'April 24, 2024',
      'time': '2:00 PM',
      'petName': 'Charlie',
      'status': 'Pending',
      'serviceType': 'Store Visit',
      'image': 'lib/images/dog1.jpeg'
    },
    {
      'date': 'April 25, 2024',
      'time': '10:00 AM',
      'petName': 'Max',
      'status': 'Confirmed',
      'serviceType': 'Trial at Home',
      'image': 'lib/images/cat1.jpeg'
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
          'My Appointments',
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
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Center(
                child: Container(
                  width: constraints.maxWidth > 600 ? 600 : constraints.maxWidth * 0.95,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(appointment['image']),
                        radius: 25,
                      ),
                      title: Text(
                        '${appointment['petName']} - ${appointment['date']} at ${appointment['time']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${appointment['serviceType']} - Status: ${appointment['status']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              _editAppointment(context, index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.brown,
                            ),
                            onPressed: () {
                              _deleteAppointment(index);
                            },
                          ),
                        ],
                      ),
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

  void _editAppointment(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Appointment'),
          content: Text('You can add more editing options here.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAppointment(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Appointment'),
          content: Text('Are you sure you want to delete this appointment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  appointments.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
