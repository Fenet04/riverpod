import 'package:flutter/material.dart';
import 'appointment_status.dart';

void main() => runApp(const PetVisitApp());

class PetVisitApp extends StatelessWidget {
  const PetVisitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Visit Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PetVisitScreen(),
        '/appoint_status': (context) => UserAppointmentsScreen(),
      },
    );
  }
}

class PetVisitScreen extends StatefulWidget {
  const PetVisitScreen({Key? key}) : super(key: key);

  @override
  _PetVisitScreenState createState() => _PetVisitScreenState();
}

class _PetVisitScreenState extends State<PetVisitScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedPet = 'Charlie';
  List<Map<String, String>> _pets = [
    {'name': 'Charlie', 'type': 'Miniature Pinscher', 'image': 'lib/images/dog1.jpeg'},
    {'name': 'Max', 'type': 'Labrador', 'image': 'lib/images/cat1.jpeg'},
    {'name': 'Bella', 'type': 'Poodle', 'image': 'lib/images/bunny1.jpeg'},
  ];
  List<bool> _isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    Color highlightColor = Theme.of(context).appBarTheme.backgroundColor ?? Colors.orange[300]!;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: highlightColor,
        elevation: 0,
        title: const Text('Schedule a Visit',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        )),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Pet', style: Theme.of(context).textTheme.titleLarge),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(_pets.firstWhere((pet) => pet['name'] == _selectedPet)['image']!),
                    ),
                    title: Text(_selectedPet),
                    subtitle: Text(_pets.firstWhere((pet) => pet['name'] == _selectedPet)['type']!),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        setState(() {
                          _selectedPet = value;
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return _pets.map((Map<String, String> pet) {
                          return PopupMenuItem<String>(
                            value: pet['name']!,
                            child: Text(pet['name']!),
                          );
                        }).toList();
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Service Type', style: Theme.of(context).textTheme.titleLarge),
                ToggleButtons(
                  fillColor: highlightColor,
                  selectedBorderColor: highlightColor,
                  selectedColor: Colors.white,
                  borderColor: Colors.grey,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Trial at home'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Store Visit'),
                    ),
                  ],
                  isSelected: _isSelected,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
                        if (buttonIndex == index) {
                          _isSelected[buttonIndex] = true;
                        } else {
                          _isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text('Select Date', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.now().add(Duration(days: index + 1));
                      return _buildDateButton(context, date, highlightColor);
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              primary: highlightColor,
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: const Text(
                    'Select from calendar',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Select Time', style: Theme.of(context).textTheme.titleLarge),
                Wrap(
                  spacing: 10,
                  children: List.generate(6, (index) => _buildTimeButton(context, index)),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[400],
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/appoint_status');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateButton(BuildContext context, DateTime date, Color highlightColor) {
    List<String> shortDayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    String dayOfWeek = shortDayNames[date.weekday - 1];
    String dayOfMonth = '${date.day}';
    
    bool isSelected = _selectedDate.year == date.year &&
                      _selectedDate.month == date.month &&
                      _selectedDate.day == date.day;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        child: Text('$dayOfWeek\n$dayOfMonth', textAlign: TextAlign.center),
        onPressed: () {
          setState(() {
            _selectedDate = date;
          });
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? highlightColor : Colors.white,
          side: BorderSide(color: isSelected ? highlightColor : Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildTimeButton(BuildContext context, int index) {
    int startTime = 9 + index;
    int endTime = startTime + 1;

    String amPmStart = startTime < 12 ? 'AM' : 'PM';
    String amPmEnd = endTime < 12 ? 'AM' : 'PM';

    String formattedStartTime = startTime > 12 ? (startTime - 12).toString().padLeft(2, '0') : startTime.toString().padLeft(2, '0');
    String formattedEndTime = endTime > 12 ? (endTime - 12).toString().padLeft(2, '0') : endTime.toString().padLeft(2, '0');

    String timeSlot = '$formattedStartTime $amPmStart - $formattedEndTime $amPmEnd';
    bool isSelected = _selectedTime.hour == startTime;

    Color highlightColor = Colors.orange[300]!;

    return OutlinedButton(
      child: Text(timeSlot),
      onPressed: () {
        setState(() {
          _selectedTime = TimeOfDay(hour: startTime, minute: 0);
        });
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: isSelected ? highlightColor : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        side: BorderSide(color: isSelected ? highlightColor : Colors.grey.shade300),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      ),
    );
  }
}
