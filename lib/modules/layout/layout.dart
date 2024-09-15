import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/layout/manager/main_provider.dart';
import 'package:todo_app/modules/layout/widgets/add_task_widget.dart';

class LayoutScreen extends StatelessWidget {
  static const String routeName = "layoutScreen";
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider()..getUser(),
      child: Selector<MainProvider, int>(
        selector: (p0, p1) => p1.selectedIndex,
        builder: (context, selectedIndex, child) {
          var provider = Provider.of<MainProvider>(context, listen: false);
          return Container(
            // decoration: BoxDecoration(
            //   gradient:
            //     LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         stops: [
            //           0.0,
            //           0.2,
            //           0.2,
            //           1
            //         ],
            //         colors: [
            //       Colors.blue,
            //       Colors.blue,
            //       Colors.white,
            //       Colors.white,
            //     ])
            //
            // ),
            child: Scaffold(
              extendBody: true,
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      context: context, builder: (context) {
                      return ChangeNotifierProvider.value(
                          value: provider,
                          child: const AddTaskWidget());
                    },);
                  },
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(360)),
                  child: const Icon(Icons.add)),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                height: 60,
                shape: const CircularNotchedRectangle(),
                color: Colors.white,
                notchMargin: 10,
                child: SizedBox(
                  height: 60,
                  child: BottomNavigationBar(
                    onTap: provider.setIndex,
                    currentIndex: selectedIndex,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.menu), label: "Tasks"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings), label: "settings")
                    ],
                  ),
                ),
              ),
              body: provider.screens[selectedIndex],
            ),
          );
        },
      ),
    );
  }
}

