import 'package:flutter/material.dart';
import 'package:flutter_pet_pal/domain/pets/pet.dart';
import 'package:flutter_pet_pal/presentation/widgets/button.dart';

class AdminPetTile extends StatelessWidget {
  final Pet pet;

  const AdminPetTile({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    pet.image,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 2,
                  left: 3,
                  right: 3,
                  child: MyButton(
                    text: 'Edit',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/form_screen',
                        arguments: pet,
                      );
                    },
                    height: 40,
                    width: double.infinity,
                    myColor: Color.fromRGBO(255, 184, 77, 0.525),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    pet.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[800],
                    size: 28,
                  ),
                  onPressed: () {
                    // Call delete method here
                  },
                ),
              ],
            ),
            Text(
              'Age: ${pet.age}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              'Gender: ${pet.gender}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              'Species: ${pet.species}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
