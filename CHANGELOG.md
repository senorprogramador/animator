## [0.0.1] - 2020/02/28

* Added Animator, TweenList, TweenPercentage and Mixins.
* Added Widgets for every Animate.css variant.

## [1.0.0] - 2020/02/29

* Minor adjustments as suggested by Pub.dev

## [1.0.01] - 2020/03/03

* Added alignment property to FlipInX to control the origin of the transform
* Added from property to FlipInX to rotate from visual front or back.

## [1.0.02] - 2020/03/03

* Adjusted widgets that use screenSize or widget size to first render with opacity 0.0.

## [1.0.03] - 2020/03/03

* Further adjusted widgets that use screenSize or widget size to first render with opacity 0.0.

## [1.0.04] - 2020/03/03

* Further adjusted widgets that use screenSize or widget size. Exit-animations now first render with opacity 1.0, entry-animations with 0.0.

## [1.1.01] - 2020/03/04

* Created AnimatorWidget and AnimatorWidgetState, further reducing code by lots.
* Added keys and control functions to animated widgets to enable starting/reversing/stopping animations from code.
* Refactored some values to AnimatorPreferences.

## [1.1.02] - 2020/03/04

* Applied dart pub suggestions on code formatting.

## [1.1.03] - 2020/03/05

* Added autoPlay feature to AnimatorPreferences and implemented it in AnimatorWidget.
* Added loop method to AnimatorWidget with an optional yoYo boolean parameter.

## [2.0.0] - 2020/03/05

* Complete rebuild of packages to further reduce code needed per animation.
* Added AnimationDefinitions.
* Added AnimationPlayState to control play states.

## [2.0.1] - 2020/03/08

* Minor documentation Update

## [2.0.2] - 2020/03/09

* Added CrossFadeAB to support cross-fading between 2 child widgets

## [2.0.3] - 2020/03/09

* Added crossToA and crossToB to CrossFadeAB.

## [2.0.4] - 2020/03/09

* Added slit_entrances and slit_exits.

## [2.0.5] - 2020/03/11

* Added documentation to classes in order to improve code later on.

## [2.0.6] - 2020/03/12

* Added support for Color animations
* Minor fix for integer animations

## [2.0.7] - 2020/04/06

* Fixed issues with reassemble, causing unmounted widgets to mount and animate.

## [2.0.8] - 2020/04/11

* Minor fix in readme stating a wrong import. (Special thanks to @atomicsink ;) )

## [2.0.9] - 2020/04/24

* Switched to master channel to validate web support.