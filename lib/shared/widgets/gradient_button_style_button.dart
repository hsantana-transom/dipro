import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

abstract class GradientButtonStyleButton extends StatefulWidget {

  const GradientButtonStyleButton({
    Key key,
    @required this.onPressed,
    @required this.onLongPress,
    @required this.style,
    @required this.focusNode,
    @required this.autofocus,
    @required this.clipBehavior,
    @required this.child,
    @required this.gradient,
  }) : assert(autofocus != null),
       assert(clipBehavior != null),
       super(key: key);

  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final ButtonStyle style;
  final Clip clipBehavior;
  final FocusNode focusNode;
  final bool autofocus;
  final Widget child;
  final Gradient gradient;

  @protected
  ButtonStyle defaultStyleOf(BuildContext context);

  @protected
  ButtonStyle themeStyleOf(BuildContext context);

  bool get enabled => onPressed != null || onLongPress != null;

  @override
  _ButtonStyleState createState() => _ButtonStyleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'));
    properties.add(DiagnosticsProperty<ButtonStyle>('style', style, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
  }

  static MaterialStateProperty<T> allOrNull<T>(T value) => value == null ? null : MaterialStateProperty.all<T>(value);

  static EdgeInsetsGeometry scaledPadding(
    EdgeInsetsGeometry geometry1x,
    EdgeInsetsGeometry geometry2x,
    EdgeInsetsGeometry geometry3x,
    double textScaleFactor,
  ) {
    assert(geometry1x != null);
    assert(geometry2x != null);
    assert(geometry3x != null);
    assert(textScaleFactor != null);

    if (textScaleFactor <= 1) {
      return geometry1x;
    } else if (textScaleFactor >= 3) {
      return geometry3x;
    } else if (textScaleFactor <= 2) {
      return EdgeInsetsGeometry.lerp(geometry1x, geometry2x, textScaleFactor - 1);
    }
    return EdgeInsetsGeometry.lerp(geometry2x, geometry3x, textScaleFactor - 2);
  }
}

class _ButtonStyleState extends State<GradientButtonStyleButton> {
  final Set<MaterialState> _states = <MaterialState>{};

  bool get _hovered => _states.contains(MaterialState.hovered);
  bool get _focused => _states.contains(MaterialState.focused);
  bool get _pressed => _states.contains(MaterialState.pressed);
  bool get _disabled => _states.contains(MaterialState.disabled);

  void _updateState(MaterialState state, bool value) {
    value ? _states.add(state) : _states.remove(state);
  }

  void _handleHighlightChanged(bool value) {
    if (_pressed != value) {
      setState(() {
        _updateState(MaterialState.pressed, value);
      });
    }
  }

  void _handleHoveredChanged(bool value) {
    if (_hovered != value) {
      setState(() {
        _updateState(MaterialState.hovered, value);
      });
    }
  }

  void _handleFocusedChanged(bool value) {
    if (_focused != value) {
      setState(() {
        _updateState(MaterialState.focused, value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateState(MaterialState.disabled, !widget.enabled);
  }

  @override
  void didUpdateWidget(GradientButtonStyleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateState(MaterialState.disabled, !widget.enabled);
    if (_disabled && _pressed) {
      _handleHighlightChanged(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle widgetStyle = widget.style;
    final ButtonStyle themeStyle = widget.themeStyleOf(context);
    final ButtonStyle defaultStyle = widget.defaultStyleOf(context);
    assert(defaultStyle != null);

    T effectiveValue<T>(T Function(ButtonStyle style) getProperty) {
      final T widgetValue  = getProperty(widgetStyle);
      final T themeValue   = getProperty(themeStyle);
      final T defaultValue = getProperty(defaultStyle);
      return widgetValue ?? themeValue ?? defaultValue;
    }

    T resolve<T>(MaterialStateProperty<T> Function(ButtonStyle style) getProperty) {
      return effectiveValue(
        (ButtonStyle style) => getProperty(style)?.resolve(_states),
      );
    }

    final TextStyle resolvedTextStyle = resolve<TextStyle>((ButtonStyle style) => style?.textStyle);
    final Color resolvedBackgroundColor = resolve<Color>((ButtonStyle style) => style?.backgroundColor);
    final Color resolvedForegroundColor = resolve<Color>((ButtonStyle style) => style?.foregroundColor);
    final Color resolvedShadowColor = resolve<Color>((ButtonStyle style) => style?.shadowColor);
    final double resolvedElevation = resolve<double>((ButtonStyle style) => style?.elevation);
    final EdgeInsetsGeometry resolvedPadding = resolve<EdgeInsetsGeometry>((ButtonStyle style) => style?.padding);
    final Size resolvedMinimumSize = resolve<Size>((ButtonStyle style) => style?.minimumSize);
    final BorderSide resolvedSide = resolve<BorderSide>((ButtonStyle style) => style?.side);
    final OutlinedBorder resolvedShape = resolve<OutlinedBorder>((ButtonStyle style) => style?.shape);

    final MaterialStateMouseCursor resolvedMouseCursor = _MouseCursor(
      (Set<MaterialState> states) => effectiveValue((ButtonStyle style) => style?.mouseCursor?.resolve(states)),
    );

    final MaterialStateProperty<Color> overlayColor = MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) => effectiveValue((ButtonStyle style) => style?.overlayColor?.resolve(states)),
    );

    final VisualDensity resolvedVisualDensity = effectiveValue((ButtonStyle style) => style?.visualDensity);
    final MaterialTapTargetSize resolvedTapTargetSize = effectiveValue((ButtonStyle style) => style?.tapTargetSize);
    final Duration resolvedAnimationDuration = effectiveValue((ButtonStyle style) => style?.animationDuration);
    final bool resolvedEnableFeedback = effectiveValue((ButtonStyle style) => style?.enableFeedback);
    final Offset densityAdjustment = resolvedVisualDensity.baseSizeAdjustment;
    final BoxConstraints effectiveConstraints = resolvedVisualDensity.effectiveConstraints(
      BoxConstraints(
        minWidth: resolvedMinimumSize.width,
        minHeight: resolvedMinimumSize.height,
      ),
    );
    final EdgeInsetsGeometry padding = resolvedPadding.add(
      EdgeInsets.only(
        left: densityAdjustment.dx,
        top: densityAdjustment.dy,
        right: densityAdjustment.dx,
        bottom: densityAdjustment.dy,
      ),
    ).clamp(EdgeInsets.zero, EdgeInsetsGeometry.infinity);

    final Widget result = ConstrainedBox(
      constraints: effectiveConstraints,
      child: Material(
        elevation: resolvedElevation,
        textStyle: resolvedTextStyle?.copyWith(color: resolvedForegroundColor),
        shape: resolvedShape.copyWith(side: resolvedSide),
        color: resolvedBackgroundColor,
        shadowColor: resolvedShadowColor,
        type: resolvedBackgroundColor == null ? MaterialType.transparency : MaterialType.button,
        animationDuration: resolvedAnimationDuration,
        clipBehavior: widget.clipBehavior,
        child: Ink(
          decoration: ShapeDecoration(
            shape: resolvedShape.copyWith(side: resolvedSide),
            gradient: widget.gradient,
          ),
          child: InkWell(
            onTap: widget.onPressed,
            onLongPress: widget.onLongPress,
            onHighlightChanged: _handleHighlightChanged,
            onHover: _handleHoveredChanged,
            mouseCursor: resolvedMouseCursor,
            enableFeedback: resolvedEnableFeedback,
            focusNode: widget.focusNode,
            canRequestFocus: widget.enabled,
            onFocusChange: _handleFocusedChanged,
            autofocus: widget.autofocus,
            splashFactory: InkRipple.splashFactory,
            overlayColor: overlayColor,
            highlightColor: Colors.transparent,
            customBorder: resolvedShape,
            child: IconTheme.merge(
              data: IconThemeData(color: resolvedForegroundColor),
              child: Padding(
                padding: padding,
                child: Center(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Size minSize;
    switch (resolvedTapTargetSize) {
      case MaterialTapTargetSize.padded:
        minSize = Size(
          kMinInteractiveDimension + densityAdjustment.dx,
          kMinInteractiveDimension + densityAdjustment.dy,
        );
        assert(minSize.width >= 0.0);
        assert(minSize.height >= 0.0);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        minSize = Size.zero;
        break;
    }

    return Semantics(
      container: true,
      button: true,
      enabled: widget.enabled,
      child: _InputPadding(
        minSize: minSize,
        child: result,
      ),
    );
  }
}

class _MouseCursor extends MaterialStateMouseCursor {
  const _MouseCursor(this.resolveCallback);

  final MaterialPropertyResolver<MouseCursor> resolveCallback;

  @override
  MouseCursor resolve(Set<MaterialState> states) => resolveCallback(states);

  @override
  String get debugDescription => 'GradientButtonStyleButton_MouseCursor';
}

class _InputPadding extends SingleChildRenderObjectWidget {
  const _InputPadding({
    Key key,
    Widget child,
    this.minSize,
  }) : super(key: key, child: child);

  final Size minSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInputPadding(minSize);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderInputPadding renderObject) {
    renderObject.minSize = minSize;
  }
}

class _RenderInputPadding extends RenderShiftedBox {
  _RenderInputPadding(this._minSize, [RenderBox child]) : super(child);

  Size get minSize => _minSize;
  Size _minSize;
  set minSize(Size value) {
    if (_minSize == value)
      return;
    _minSize = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child.getMinIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child.getMinIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child.getMaxIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child.getMaxIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      final double height = math.max(child.size.width, minSize.width);
      final double width = math.max(child.size.height, minSize.height);
      size = constraints.constrain(Size(height, width));
      final BoxParentData childParentData = child.parentData as BoxParentData;
      childParentData.offset = Alignment.center.alongOffset(size - child.size as Offset);
    } else {
      size = Size.zero;
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, { Offset position }) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final Offset center = child.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (BoxHitTestResult result, Offset position) {
        assert(position == center);
        return child.hitTest(result, position: center);
      },
    );
  }
}
