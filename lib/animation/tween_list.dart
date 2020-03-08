import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:vector_math/vector_math_64.dart';

import 'tween_percentage.dart';
import '../utils/pair.dart';

///[TweenList] is a [Tween] which contains a list of [TweenPercentage]s to
///enable users to efficiently define a multi-curved animation with multiple
///value-blends.
///Please note that although Matrix4 tweens are supported, the tend to be a bit
///slower, due to the Matrix decomposition
class TweenList<T extends dynamic> extends Tween<T> {
  List<TweenPercentage<T>> _values;
  Pair<TweenPercentage<T>, TweenPercentage<T>> _pair;
  Animation<T> animation;
  Duration offset = Duration.zero;
  Duration duration = Duration(seconds: 1);

  TweenList(List<TweenPercentage<T>> values) {
    _values = values;
    _values.sort((a, b) => a.percent.compareTo(b.percent));
  }

  Pair<TweenPercentage<T>, TweenPercentage<T>> fetchFromTo(double t) {
    final a = _values.reversed.firstWhere(
        (element) => element.percent < t * 100.0,
        orElse: () => _values.first);
    final b = _values.firstWhere((element) => element.percent >= t * 100.0,
        orElse: () => _values.last);
    return Pair(a, b);
  }

  @override
  T transform(double t) {
    double beginT =
        offset.inMilliseconds.toDouble() / duration.inMilliseconds.toDouble();
    double endT = 1.0;

    double nt = (t - beginT) / (endT - beginT);

    return lerp(nt);
  }

  Quaternion qlerp(Quaternion qa, Quaternion qb, double t2) {
    Quaternion qm;
    double t1 = 1.0 - t2;
    qm = qa.scaled(t1) + qb.scaled(t2);
    double len = sqrt(qm.x * qm.x + qm.y * qm.y + qm.z * qm.z + qm.w * qm.w);
    qm.scale(1.0 - len);
    return qm;
  }

  @override
  T lerp(double t) {
    if (t <= 0.0) {
      return _values.first.value;
    }
    if (t >= 1.0) {
      return _values.last.value;
    }

    if (_pair == null ||
        _pair.b.percent < t * 100.0 ||
        _pair.a.percent > t * 100.0) {
      _pair = fetchFromTo(t);
    }

    if (t * 100.0 <= _pair.a.percent) {
      return _pair.a.value;
    }
    if (t * 100.0 >= _pair.b.percent) {
      return _pair.b.value;
    }

    final n = _pair.a.curve.transform(
        (t * 100.0 - _pair.a.percent) / (_pair.b.percent - _pair.a.percent));

    if (T == Matrix4) {
      final Vector3 beginTranslation = Vector3.zero();
      final Vector3 endTranslation = Vector3.zero();
      final Quaternion beginRotation = Quaternion.identity();
      final Quaternion endRotation = Quaternion.identity();
      final Vector3 beginScale = Vector3.zero();
      final Vector3 endScale = Vector3.zero();

      _pair.a.value.decompose(beginTranslation, beginRotation, beginScale);
      _pair.b.value.decompose(endTranslation, endRotation, endScale);

      final Vector3 lerpTranslation =
          beginTranslation * (1.0 - n) + endTranslation * n;
      final Quaternion lerpRotation =
          qlerp(beginRotation, endRotation, n).normalized();
      final Vector3 lerpScale = beginScale * (1.0 - n) + endScale * n;

      return Matrix4.compose(lerpTranslation, lerpRotation, lerpScale) as T;
    }

    return _pair.a.value + n * (_pair.b.value - _pair.a.value) as T;
  }
}
