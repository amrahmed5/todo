import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../controllers/controller.dart';

import '../widgets/bottom/bottom_sheet.dart';
import '../widgets/expan.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          backgroundColor: const Color(0xfffefef),
          appBar: AppBar(
            backgroundColor: const Color(0xfffefefe),
            toolbarHeight: 100,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    color: Color(0xff141414),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${DateFormat.EEEE().format(DateTime.now())}, ${DateTime.now().day}, ${DateFormat.MMM().format(DateTime.now())} ${DateTime.now().year}',
                      style: const TextStyle(color:Colors.black87, fontSize: 28),
                    ),
                    const SizedBox(width: 23),
                    const Icon(Icons.calendar_today, color: Colors.black),
                  ],
                ),

              ],
            ),
          ),
          body: ListView.builder(
            itemCount: TaskController.panels.length,
            itemBuilder: (context, index) {
              final panel = TaskController.panels[index];
              return ExpansionPanelItem(
                panel: panel,
                onDeleteTask: (task) {
                  setState(() {
                    TaskController.deleteTask(panel, task);
                    if (panel.items.isEmpty) {
                      TaskController.deletePanel(panel);
                    }
                  });
                },

              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              side: const BorderSide(
                color: Colors.white,
                width: 2,
                style: BorderStyle.solid,
              ),
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                context: context,
                builder: (context) {
                  return TaskBottomSheet(
                    onAdd: (panel) {
                      setState(() {
                        TaskController.addPanel(panel);
                      });
                    },
                  );
                },
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  "Add Task",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}