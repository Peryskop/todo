import 'package:flutter/material.dart';

class FadeIn {
  AnimationController controller;

  void prepareController(vsync) {
    this.controller = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 500),
    );
  }

  void forward() {
    this.controller.forward();
  }

  Animation() {
    return Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(this.controller);
  }
}
