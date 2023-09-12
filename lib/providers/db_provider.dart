import 'package:beerapp/util/classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DBProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> addPerson(String name) async {
    try {
      await getPerson(name);
      return 'Person already exists';
    } catch (e) {
      await _db.collection('persons').add(Person(id: '', name: name, beers: 0).toJson());
      return 'Person added';
    }
  }

  Future<Person> getPerson(String name) async {
    final personRef = _db.collection('persons');
    final person = await personRef.where('name', isEqualTo: name).get();

    if (person.docs.isEmpty) {
      throw Exception('No person found with name $name');
    }
    return Person.fromJson(person.docs.first.data(), person.docs.first.id);
  }

  Future addBeerToPerson(String name) async {
    final person = await getPerson(name);
    final newPerson = Person(id: person.id, name: person.name, beers: person.beers + 1);
    _db.collection('persons').doc(person.id).update(newPerson.toJson());
  }
}
