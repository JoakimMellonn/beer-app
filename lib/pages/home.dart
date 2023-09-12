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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: const Text(
            'Drink?',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
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
          List<QueryDocumentSnapshot<Object?>> docsBeersSorted = snapshot.data!.docs.toList();
          docs.sort((a, b) {
            final personA = Person.fromJson(a.data() as Map<String, dynamic>, a.id);
            final personB = Person.fromJson(b.data() as Map<String, dynamic>, b.id);
            if (personA.name == personB.name) {
              return personB.beers.compareTo(personA.beers);
            }
            return personA.name.compareTo(personB.name);
          });
          docsBeersSorted.sort((a, b) {
            final personA = Person.fromJson(a.data() as Map<String, dynamic>, a.id);
            final personB = Person.fromJson(b.data() as Map<String, dynamic>, b.id);
            if (personA.beers == personB.beers) {
              return personA.name.compareTo(personB.name);
            }
            return personB.beers.compareTo(personA.beers);
          });

          return ListView.builder(
            itemCount: docs.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                // This is bad... but it works
                return Column(
                  children: [
                    const Center(
                      child: Text(
                        'Top 3',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    PersonLine(person: Person.fromJson(docsBeersSorted[0].data() as Map<String, dynamic>, docsBeersSorted[0].id)),
                    PersonLine(person: Person.fromJson(docsBeersSorted[1].data() as Map<String, dynamic>, docsBeersSorted[1].id)),
                    PersonLine(person: Person.fromJson(docsBeersSorted[2].data() as Map<String, dynamic>, docsBeersSorted[2].id)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Divider(
                        height: 60,
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Everyone',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                );
                // If it's stupid but it works, it ain't stupid
              }
              final person = Person.fromJson(docs[index - 1].data() as Map<String, dynamic>, docs[index - 1].id);
              return PersonLine(person: person);
            },
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          onPressed: () {
            // navigate to newPerson page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewPersonPage(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 50,
          ),
        ),
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
        padding: const EdgeInsets.all(30),
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
              style: const TextStyle(fontSize: 25),
            ),
            const Spacer(),
            Text(
              '${person.beers.toString()} drinks',
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
