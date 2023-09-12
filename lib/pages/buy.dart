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
      appBar: AppBar(
        title: Text('Buy for ${widget.person.name}'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
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
          child: const Text('Buy'),
        ),
      ),
    );
  }
}
