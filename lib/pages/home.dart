import 'package:beerapp/pages/buy.dart';
import 'package:beerapp/pages/new_person.dart';
import 'package:beerapp/util/classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> personStream = FirebaseFirestore.instance.collection('persons').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drink?'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: personStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Text("Such empty");
          }

          List<QueryDocumentSnapshot<Object?>> docs = snapshot.data!.docs.toList();
          docs.sort((a, b) {
            final personA = Person.fromJson(a.data() as Map<String, dynamic>, a.id);
            final personB = Person.fromJson(b.data() as Map<String, dynamic>, b.id);
            return personB.beers.compareTo(personA.beers);
          });

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final person = Person.fromJson(docs[index].data() as Map<String, dynamic>, docs[index].id);
              return PersonLine(person: person);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigate to newPerson page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewPersonPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PersonLine extends StatelessWidget {
  final Person person;

  const PersonLine({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyPage(person: person),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              person.name,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Text(
              '${person.beers.toString()} drinks',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
