import 'package:flutter/material.dart';

class ThongKeTienDoMauScreen extends StatefulWidget {
  const ThongKeTienDoMauScreen({super.key});

  @override
  State<ThongKeTienDoMauScreen> createState() => _State();
}

class _State extends State<ThongKeTienDoMauScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}