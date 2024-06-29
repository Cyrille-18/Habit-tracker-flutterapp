import 'package:flutter/material.dart';
import '../models/habit.dart';

class createhabit extends StatefulWidget {
  habit? habitude = habit(id: 0, nom: "", etat: false);
  final Function(habit) addHabit;

  createhabit({super.key, this.habitude, required this.addHabit});

  @override
  State<createhabit> createState() => _createhabitState();
}

class _createhabitState extends State<createhabit> {
  TextEditingController nom_habit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nom'),
      content: TextField(
        controller: nom_habit,
        decoration:
            InputDecoration(hintText: "Entrer le nom de votre habitude"),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Ajouter'),
          onPressed: () {
            habit new_Habit = habit(id: 0, nom: nom_habit.text, etat: false);
            widget.addHabit(new_Habit);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    ;
  }
}
