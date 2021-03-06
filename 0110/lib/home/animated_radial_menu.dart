library animated_radial_menu;
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'GetxController.dart';

class RadialMenu extends StatefulWidget {
  // will take in list of buttons
  final List<RadialButton> children;

  // used for positioning the widget
  final AlignmentGeometry centerButtonAlignment;

  // set main button size
  final double centerButtonSize;

  // constructor for main button
  RadialMenu(
      {Key? key,
      required this.children,
      this.centerButtonSize = 0.5,
      this.centerButtonAlignment = Alignment.center})
      : super(key: key);

  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  // used to control animations
  AnimationController? controller;

  // controller gets initialized here
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.centerButtonAlignment,
      child: SizedBox(
        width: 250,
        height: 250,
        child: RadialAnimation(
          controller: controller!,
          radialButtons: widget.children,
          centerSizeOfButton: 0.9,
        ),
      ),
    );
  }

  // controller gets disposed here
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

// Here all the animation will take place
class RadialAnimation extends StatelessWidget {
  RadialAnimation(
      {Key? key,
      required this.controller,
      required this.radialButtons,
      this.centerSizeOfButton = 0.5})
      :
        // translation animation
        translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),

        // scaling animation
        scale = Tween<double>(
          begin: centerSizeOfButton * 4,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),

        // rotation animation
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.7,
              curve: Curves.decelerate,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;
  final List<RadialButton> radialButtons;
  final double centerSizeOfButton;

  @override
  Widget build(BuildContext context) {
    // will provide angle for further calculation
    double generatedAngle = 360 / (radialButtons.length);
    double iconAngle;

    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Stack(alignment: Alignment.center, children: [
            // generates list of buttons
            ...radialButtons.map((index) {
              iconAngle = radialButtons.indexOf(index) * generatedAngle;
              return _buildButton(iconAngle,
                  color: index.buttonColor,
                  icon: index.icon,
                  onPress: index.onPress);
            }),
            //  secondary button animation

            Transform.scale(
                scale: scale.value - (centerSizeOfButton * 2 - 0.25),
                child: FloatingActionButton(
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: SvgPicture.asset("assets/icon2.svg"),
                    ),
                  ),
                  onPressed: () {
                    //?????? ????????? ????????? ?????? true false;
                    close();
                  },
                  // style: ElevatedButton.styleFrom(
                  //   shape: CircleBorder(),
                  //   padding: EdgeInsets.all(0),
                  //   primary: Colors.white, // <-- Button color
                  //   onPrimary: Colors.red, // <-- Splash color
                  // ),
                )),
            // primary button animation
            Transform.scale(
                scale: scale.value,
                child: FloatingActionButton(
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: SvgPicture.asset("assets/icon1.svg"),
                    ),
                  ),
                  onPressed: () {
                    open();
                  },
                  // style: ElevatedButton.styleFrom(
                  //   shape: CircleBorder(),
                  //   padding: EdgeInsets.all(0),
                  //   primary: Colors.white, // <-- Button color
                  //   onPrimary: Colors.red, // <-- Splash color
                  // ),
                ))
          ]);
        });
  }

  // will show child buttons
  void open() {
    // final controllerDark = Get.put(darkController());
    // controllerDark.darkFunc();
    // print(controllerDark.dark.value);
    Get.find<BuilderController>().changefalse();
    controller.forward();
  }

  // will hide child buttons
  void close() {
    // final controllerDark = Get.put(darkController());
    // controllerDark.darkFunc();
    // print(controllerDark.dark.value);
    Get.find<BuilderController>().changetrue();
    controller.reverse();
  }

  // build custom child buttons
  Widget _buildButton(double angle,
      {Function? onPress, Color? color, Icon? icon}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FloatingActionButton(
            child: icon,
            backgroundColor: color,
            onPressed: () {
              onPress!();
              close();
            },
            elevation: 0));
  }
}

class RadialButton {
  // background colour of the button surrounding the icon
  final Color buttonColor;

  // sets icon of the child buttons
  final Icon icon;

  // onPress function of the child buttons
  final Function onPress;

  final ButtonStyle style;
  // constructor for child buttons
  RadialButton(
      {this.buttonColor = Colors.orange,
      required this.icon,
      required this.onPress,
      required this.style});
}
