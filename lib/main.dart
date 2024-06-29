import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../screens/createhabit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Suivi d'habitudes",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF035AA6)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Suivi d'habitudes"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<habit> habits = [];

  void addHabit(habit habitude) {
    setState(() {
      habits.add(habitude);
    });
  }

  void dialogHabit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return createhabit(addHabit: addHabit);
      },
    );
  }

  void CheckboxChanged(habit habitude, bool value) {
    setState(() {
      habitude.etat = value;
    });

    if (value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          habits.remove(habitude);
        });
      });
    }
  }

  void supprimerHabitude(habit habitude) {
    setState(() {
      habits.remove(habitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: habits.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_satisfied,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Vous n'avez pas d'habitudes pour le moment. Appuyez sur le bouton pour en créer.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      habit currentHabit = habits[index];

                      return Card(
                        margin: EdgeInsets.all(8.0),
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentHabit.nom,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: currentHabit.etat,
                                    onChanged: (bool? value) {
                                      if (value != null) {
                                        CheckboxChanged(currentHabit, value);
                                      }
                                    },
                                    activeColor: Colors.green,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      supprimerHabitude(currentHabit);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: dialogHabit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
