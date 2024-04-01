import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Animation<Offset>> slideAnimation = [];
  int noOfCount = 5;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    slideAnimation = List.generate(
      noOfCount,
      (index) =>
          Tween(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(index * (1 / noOfCount),
              1), // 0.2 seconds of delayed for every animation
        ),
      ),
    );

    // slideAnimation =
    //     Tween(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: Interval(0.2, 1),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: slideAnimation[index],
            child: ListTile(
              title: Text('Hello World, Rivaan. ${index.toString()}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
