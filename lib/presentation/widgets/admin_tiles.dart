import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'button.dart';

class AllTile extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String species;
  final String imagePath;

  const AllTile(
      {super.key,
      required this.name,
      required this.age,
      required this.gender,
      required this.species,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.orange[200], borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Image.asset(
                width: double.infinity,
                imagePath,
                height: 200,
                fit: BoxFit.fill,
              ),
              
            ]),

            //name
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                
              ],
            ),

            //age

            Text(
              age,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            //gender

            Text(
              gender,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            //species

            Text(
              species,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey[800],
                    size: 28,
                  ),
                  onPressed: () {},

                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey[800],
                    size: 28,
                  ),
                  onPressed: () {},
                  
                ),
            ]),
            
            //button
          ],
        ),
      ),
    );
  }
}
