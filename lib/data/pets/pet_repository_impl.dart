// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:dartz/dartz.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../../domain/pets/pet.dart';
// import '../../domain/pets/pet_repository.dart';
// import '../../domain/auth/auth_failure.dart';

// class PetRepositoryImpl implements PetRepository {
//   final http.Client client;
//   final String baseUrl;
//   final FlutterSecureStorage secureStorage;

//   PetRepositoryImpl(this.client, this.baseUrl, this.secureStorage);

//   @override
//   Future<Either<AuthFailure, List<Pet>>> fetchPets() async {
//     final url = Uri.parse('$baseUrl/pets');
//     try {
//       final response = await client.get(url);

//       if (response.statusCode == 200) {
//         final List<dynamic> petsJson = jsonDecode(response.body);
//         final pets = petsJson.map((json) => Pet.fromJson(json)).map((pet) {
//           // Update the image URL to be a full URL
//           pet = pet.copyWith(image: '$baseUrl/${pet.image}');
//           return pet;
//         }).toList();
//         return right(pets);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure.serverError());
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure.networkError());
//     }
//   }

//   @override
//   Future<Either<AuthFailure, Pet>> fetchPetById(String id) async {
//     final url = Uri.parse('$baseUrl/pets/$id');
//     try {
//       final response = await client.get(url);

//       if (response.statusCode == 200) {
//         final pet = Pet.fromJson(jsonDecode(response.body));
//         return right(pet);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure.serverError());
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure.networkError());
//     }
//   }

//   @override
//   Future<Either<AuthFailure, Unit>> addPet(Pet pet) async {
//     final url = Uri.parse('$baseUrl/pets');
//     try {
//       final response = await client.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(pet.toJson()),
//       );

//       if (response.statusCode == 201) {
//         return right(unit);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure.serverError());
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure.networkError());
//     }
//   }

//   @override
//   Future<Either<AuthFailure, Unit>> updatePet(String id, Pet updatedPet) async {
//     final url = Uri.parse('$baseUrl/pets/$id');
//     try {
//       final response = await client.put(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(updatedPet.toJson()),
//       );

//       if (response.statusCode == 200) {
//         return right(unit);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure.serverError());
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure.networkError());
//     }
//   }

//   @override
//   Future<Either<AuthFailure, Unit>> deletePet(String id) async {
//     final url = Uri.parse('$baseUrl/pets/$id');
//     try {
//       final response = await client.delete(url);

//       if (response.statusCode == 204) {
//         return right(unit);
//       } else {
//         print('Error: ${response.body}');
//         return left(AuthFailure.serverError());
//       }
//     } catch (e) {
//       print('Network error: $e');
//       return left(AuthFailure.networkError());
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/pets/pet.dart';
import '../../domain/pets/pet_repository.dart';
import '../../domain/auth/auth_failure.dart';

class PetRepositoryImpl implements PetRepository {
  final http.Client client;
  final String baseUrl;
  final FlutterSecureStorage secureStorage;

  PetRepositoryImpl(this.client, this.baseUrl, this.secureStorage);

  Future<String?> _getToken() async {
    return await secureStorage.read(key: 'token');
  }

  @override
  Future<Either<AuthFailure, List<Pet>>> fetchPets() async {
    final url = Uri.parse('$baseUrl/pets');
    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> petsJson = jsonDecode(response.body);
        final pets = petsJson.map((json) => Pet.fromJson(json)).map((pet) {
          // Update the image URL to be a full URL
          pet = pet.copyWith(image: '$baseUrl/${pet.image}');
          return pet;
        }).toList();
        return right(pets);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure.serverError());
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure.networkError());
    }
  }

  @override
  Future<Either<AuthFailure, Pet>> fetchPetById(String id) async {
    final url = Uri.parse('$baseUrl/pets/$id');
    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final pet = Pet.fromJson(jsonDecode(response.body));
        return right(pet);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure.serverError());
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure.networkError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> addPet(Pet pet) async {
    final url = Uri.parse('$baseUrl/pets');
    final token = await _getToken();
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(pet.toJson()),
      );

      if (response.statusCode == 201) {
        return right(unit);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure.serverError());
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure.networkError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updatePet(String id, Pet updatedPet) async {
    final url = Uri.parse('$baseUrl/pets/$id');
    final token = await _getToken();
    try {
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedPet.toJson()),
      );

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure.serverError());
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure.networkError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> deletePet(String id) async {
    final url = Uri.parse('$baseUrl/pets/$id');
    final token = await _getToken();
    try {
      final response = await client.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        return right(unit);
      } else {
        print('Error: ${response.body}');
        return left(AuthFailure.serverError());
      }
    } catch (e) {
      print('Network error: $e');
      return left(AuthFailure.networkError());
    }
  }
}
