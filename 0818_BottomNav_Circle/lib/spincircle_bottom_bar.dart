library spincircle_bottom_bar;

import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/modals.dart';

class SpinCircleBottomBarHolder extends StatelessWidget {
  final SCBottomBarDetails bottomNavigationBar;
  final Widget child;

  const SpinCircleBottomBarHolder({
    Key? key,
    required this.bottomNavigationBar,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(child: child),
            Container(
              height: bottomNavigationBar.bnbHeight ?? 80,
            )
          ],
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: SpinCircleBottomBar(
              bottomNavigationBar: bottomNavigationBar,
            )
        )
      ],
    );
  }
}

class SpinCircleBottomBar extends StatefulWidget {
  final SCBottomBarDetails bottomNavigationBar;

  const SpinCircleBottomBar({
    Key? key,
    required this.bottomNavigationBar
  }) : super(key: key);

  @override
  _SpinCircleBottomBarState createState() => _SpinCircleBottomBarState();
}

enum ExpansionStatus { open, close, idle }

class _SpinCircleBottomBarState extends State<SpinCircleBottomBar> {
  ExpansionStatus expansionStatus = ExpansionStatus.idle;
  late SCBottomBarDetails expandableBottomBarDetails;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    expandableBottomBarDetails = widget.bottomNavigationBar;
    expandableBottomBarDetails.items.insert((expandableBottomBarDetails.items.length / 2).floor(), null);
    expandableBottomBarDetails.circleColors = expandableBottomBarDetails.circleColors ?? [Colors.white, Colors.blue, Colors.red];
    expandableBottomBarDetails.actionButtonDetails = expandableBottomBarDetails.actionButtonDetails ?? SCActionButtonDetails(
        color: Colors.blue,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 0
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final double bottomBarHeight = expandableBottomBarDetails.bnbHeight ?? 80;
    final IconThemeData iconTheme = expandableBottomBarDetails.iconTheme ?? const IconThemeData(color: Colors.black45);
    final IconThemeData activeIconTheme = expandableBottomBarDetails.activeIconTheme ?? const IconThemeData(color: Colors.black);
    final TextStyle textStyle = expandableBottomBarDetails.titleStyle ?? const TextStyle(color: Colors.black45, fontWeight: FontWeight.normal, fontSize: 12);
    final TextStyle activeTextStyle = expandableBottomBarDetails.activeTitleStyle ?? const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12);
    final SCActionButtonDetails? actionButtonDetails = expandableBottomBarDetails.actionButtonDetails;

    final bool shouldOpen = expansionStatus == ExpansionStatus.open;

    return Container(
        height: bottomBarHeight * 2,
        width: width,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: <Widget>[
            if (expansionStatus != ExpansionStatus.idle) ...[
              SizedBox(
                  width: width,
                  height: bottomBarHeight * 2,
                  child: Stack(
                    children: <Widget>[
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: shouldOpen ? -3.14 : 0, end: shouldOpen ? 0 : -3.14),
                        curve: Curves.easeInOutQuad,
                        duration: Duration(milliseconds: shouldOpen ? 500 : 800),
                        builder: (BuildContext context, double value, Widget? child) {
                          return Transform.rotate(
                            angle: value,
                            alignment: Alignment.bottomCenter,
                            child: child,
                          );
                        },
                        child: EmptyLayer(
                          radius: bottomBarHeight * 2,
                          color: expandableBottomBarDetails.circleColors![2],
                        ),
                      ),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: shouldOpen ? -3.14 : 0, end: shouldOpen ? 0 : -3.14),
                        curve: Curves.easeInOutQuad,
                        duration: const Duration(milliseconds: 600),
                        builder: (BuildContext context, double value, Widget? child) {
                          return Transform.rotate(
                            angle: value,
                            alignment: Alignment.bottomCenter,
                            child: child,
                          );
                        },
                        child: EmptyLayer(
                          radius: bottomBarHeight * 2,
                          color: expandableBottomBarDetails.circleColors![1],
                        ),
                      ),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: shouldOpen ? -3.14 : 0, end: shouldOpen ? 0 : -3.14),
                        duration: Duration(milliseconds: shouldOpen ? 800 : 500),
                        curve: Curves.easeInOutQuad,
                        builder: (BuildContext context, double value, Widget? child) {
                          return Transform.rotate(
                            angle: value,
                            alignment: Alignment.bottomCenter,
                            child: child,
                          );
                        },
                        child: PrimaryCircle(
                          circleItems: expandableBottomBarDetails.circleItems,
                          radius: bottomBarHeight * 2,
                          color: expandableBottomBarDetails.circleColors![0],
                        ),
                      ),
                    ],
                  )
              )
            ],
            Positioned(
              bottom: 0,
              child: Container(
                height: bottomBarHeight,
                width: width,
                decoration: BoxDecoration(
                    color: expandableBottomBarDetails.backgroundColor ?? Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(55),
                          offset: Offset(0, expandableBottomBarDetails.elevation ?? 0),
                          blurRadius: 10
                      )
                    ]
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: expandableBottomBarDetails.items.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final SCBottomBarItem? itemDetails = entry.value;
                        final bool isActive = activeIndex == index;
                        return Flexible(
                            child: itemDetails != null ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeIndex = index;
                                });
                                itemDetails.onPressed();
                              },
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      isActive ? itemDetails.activeIcon ?? itemDetails.icon : itemDetails.icon,
                                      color: isActive ? activeIconTheme.color : iconTheme.color,
                                      size: isActive ? activeIconTheme.size : iconTheme.size,
                                    ),
                                    itemDetails.title != null ? Text(
                                        itemDetails.title ?? "",
                                        style: isActive ? activeTextStyle : textStyle
                                    ) : const Center()
                                  ],
                                ),
                              ),
                            ) : const Center()
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                height: bottomBarHeight * 2,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(
                      begin: shouldOpen ? 0.0 : 6.28319,
                      end: shouldOpen ? 6.28319 : 0
                  ),
                  duration: const Duration(milliseconds: 250),
                  builder: (BuildContext context, double angle, Widget? child) {
                    return Transform.rotate(
                        angle: expansionStatus == ExpansionStatus.idle ? 0.0 : angle,
                        child: child
                    );
                  },
                  child: FloatingActionButton(
                      elevation: actionButtonDetails!.elevation,
                      backgroundColor: actionButtonDetails.color,
                      onPressed: () {
                        if (expansionStatus == ExpansionStatus.idle) {
                          setState(() {
                            expansionStatus = ExpansionStatus.open;
                          });
                        } else {
                          setState(() {
                            expansionStatus = (expansionStatus == ExpansionStatus.open) ? ExpansionStatus.close : ExpansionStatus.open;
                          });
                        }
                      },
                      child: shouldOpen ? const Icon(Icons.close) : actionButtonDetails.icon
                  ),
                )
            ),
          ],
        )
    );
  }
}

class PrimaryCircle extends StatelessWidget {
  final List<SCItem> circleItems;
  final Color color;
  final double radius;

  const PrimaryCircle({
    Key? key,
    required this.color,
    required this.radius,
    required this.circleItems
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radianGap = 3.14159 / circleItems.length;
    final double start = radianGap / 2;
    return ClipRect(
      child: Align(
        heightFactor: 0.5,
        alignment: Alignment.topCenter,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: circleItems.asMap().entries.map((entry) {
                final SCItem value = entry.value;
                return Transform.translate(
                    offset: Offset.fromDirection(
                        -(start + (entry.key * radianGap)),
                        radius / 3
                    ),
                    child: GestureDetector(
                      onTap: value.onPressed,
                      child: value.icon,
                    )
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyLayer extends StatelessWidget {
  final Color color;
  final double radius;

  const EmptyLayer({
    Key? key,
    required this.color,
    required this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        heightFactor: 0.5,
        alignment: Alignment.topCenter,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: const Center(),
        ),
      ),
    );
  }
}