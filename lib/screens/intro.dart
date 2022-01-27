import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'home.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      showDoneButton: true,
      showNextButton: true,
      showSkipButton: false,
      done: const Text("Done"),
      onDone: () => Get.to(() => Home()),
      next: const Text("Next"),
      pages: [
        PageViewModel(
            image: SvgPicture.asset('assets/intro1.svg'),
            title: "ToDoApp",
            body: "Simple Firebase backed TODO Application - 1/2"),
        PageViewModel(
            image: SvgPicture.asset('assets/intro2.svg'),
            title: "ToDoApp",
            body: "Simple Firebase backed TODO Application  - 2/2")
      ],
    );
  }
}

