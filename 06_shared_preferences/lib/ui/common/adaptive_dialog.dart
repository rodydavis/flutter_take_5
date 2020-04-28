import 'package:flutter/material.dart';

const kDialogSize = Size(450, 700);

class AdaptiveDialog extends StatelessWidget {
  final Widget child;

  const AdaptiveDialog({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        if (dimens.maxWidth < kDialogSize.width ||
            dimens.maxHeight < kDialogSize.height) {
          return child;
        }
        return Center(
          child: SizedBox.fromSize(
            size: kDialogSize,
            child: AspectRatio(
              aspectRatio: 1,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
