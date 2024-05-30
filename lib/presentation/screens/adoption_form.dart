import 'package:flutter/material.dart';
import 'adoption_status_page.dart';

void main() {
  runApp(AdoptionForm());
}

class AdoptionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AdoptionFormScreen(),
        '/status': (context) => ApplicationStatusScreen(),
      },
    );
  }
}

class AdoptionFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0,
        title: Text(
          'Adopt a Pet',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: constraints.maxWidth > 600 ? 600 : constraints.maxWidth * 0.9,
                padding: EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      buildTextFormField(label: 'Full Name'),
                      SizedBox(height: 16.0),
                      buildTextFormField(label: 'Address'),
                      SizedBox(height: 16.0),
                      buildTextFormField(label: 'Phone Number', inputType: TextInputType.phone),
                      SizedBox(height: 16.0),
                      buildDropdownField(label: 'Type of Pet', items: ['Dog', 'Cat', 'Rabbit', 'Other']),
                      SizedBox(height: 16.0),
                      buildDropdownField(label: 'Gender', items: ['Male', 'Female', 'Any']),
                      SizedBox(height: 16.0),
                      buildDropdownField(label: 'Age Range', items: ['Baby', 'Young', 'Adult', 'Senior']),
                      SizedBox(height: 32.0),
                      buildTextFormField(label: 'Previous Pet Ownership Experience', maxLines: 5),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[400],
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/status');
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextFormField({required String label, int maxLines = 1, TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: inputType,
      maxLines: maxLines,
    );
  }

  Widget buildDropdownField({required String label, required List<String> items}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }
}
