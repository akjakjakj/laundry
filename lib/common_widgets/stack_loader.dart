import 'package:flutter/material.dart';

class StackLoader extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  const StackLoader({
    Key? key,
    required this.child,
    this.inAsyncCall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        inAsyncCall
            ? const Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.3,
                    child:
                        ModalBarrier(dismissible: false, color: Colors.white),
                  ),
                  CircularProgressIndicator()
                ],
              )
            : const SizedBox()
      ],
    );
  }
}