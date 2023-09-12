import 'package:beerapp/providers/db_provider.dart';
import 'package:beerapp/util/classes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyPage extends StatefulWidget {
  final Person person;
  const BuyPage({super.key, required this.person});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: Text(
            'Buy for ${widget.person.name}',
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            context.read<DBProvider>().addBeerToPerson(widget.person.name);
            // show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added drink to ${widget.person.name}'),
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
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
            height: 100,
            width: 250,
            padding: const EdgeInsets.all(20),
            child: const Center(
              child: Text(
                'Buy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
