// ignore_for_file: use_build_context_synchronously

import 'package:beerapp/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPersonPage extends StatefulWidget {
  const NewPersonPage({super.key});

  @override
  State<NewPersonPage> createState() => _NewPersonPageState();
}

class _NewPersonPageState extends State<NewPersonPage> {
  final formKey = GlobalKey<FormState>();
  String name = '';

  void addPerson() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final result = await context.read<DBProvider>().addPerson(name);
    if (result == 'Person added') {
      Navigator.pop(context);
    } else {
      // show alert dialog if name already exists
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(result),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Person'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                onFieldSubmitted: (value) => addPerson(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => addPerson(),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
