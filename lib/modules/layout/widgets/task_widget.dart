import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/modules/layout/manager/main_provider.dart';

class TaskWidget extends StatelessWidget {
  TaskModel task;
  TaskWidget({
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slidable(
            key: ValueKey(task.id),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                provider.deleteTask(task.id);
              }),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (context) {
                    provider.deleteTask(task.id);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (context) {},
                  backgroundColor: const Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 60,
                    decoration: BoxDecoration(
                        color: task.isDone ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: task.isDone ? Colors.green : Colors.blue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(task.desc),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.timelapse),
                          Text(task.time),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  task.isDone
                      ? InkWell(
                          onTap: () {
                            provider.setDone(task);
                          },
                          child: const Text(
                            "Done..!",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            provider.setDone(task);
                          },
                          child: Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
