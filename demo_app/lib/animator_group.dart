import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/utils/force_unwrap.dart';

class AnimatorCard extends StatelessWidget {
  final String title;
  final Color? color;
  AnimatorCard(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 5),
      width: 300,
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class AnimatorGroup extends StatefulWidget {
  final AnimationPlayStates? playState;
  AnimatorGroup({Key? key, required this.playState}) : super(key: key);

  @override
  AnimatorGroupState createState() => AnimatorGroupState();
}

class AnimatorGroupState<T extends AnimatorGroup> extends State<T> {
  int get numKeys => 0;

  List<GlobalKey<AnimatorWidgetState>> keys = [];
  List<Color?> colors = [
    Colors.blue[100],
    Colors.green[100],
    Colors.blue[200],
    Colors.green[200],
    Colors.blue[300],
    Colors.green[300],
    Colors.blue[400],
    Colors.green[400],
    Colors.blue[500],
    Colors.green[500],
    Colors.blue[600],
    Colors.green[600],
    Colors.blue[700],
    Colors.green[700],
    Colors.blue[800],
    Colors.green[800],
    Colors.blue[900],
    Colors.green[900],
  ];
  AnimationPlayStates? playState;

  @override
  void initState() {
    keys = List.generate(numKeys, (_) => GlobalKey<AnimatorWidgetState>());
    playState = widget.playState;
    forceUnwrap(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      handlePlayState();
    });
    super.initState();
  }

  @override
  void reassemble() {
    if (mounted) {
      handlePlayState();
    }
    super.reassemble();
  }

  void reverse() {
    setState(() {
      playState = AnimationPlayStates.Reverse;
    });
    handlePlayState();
  }

  void stop() {
    setState(() {
      playState = AnimationPlayStates.None;
    });
    handlePlayState();
  }

  void forward() {
    setState(() {
      playState = AnimationPlayStates.Forward;
    });
    handlePlayState();
  }

  void loop() {
    setState(() {
      playState = AnimationPlayStates.Loop;
    });
    handlePlayState();
  }

  handlePlayState() {
    keys.forEach((key) {
      if (key.currentState != null) {
        key.currentState!.handlePlayState(playState);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
