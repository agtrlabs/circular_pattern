# circular_pattern

Circular Pattern is a flutter package similar to mobile pattern lock which dots designed in a circular form

## Features

- A string symbol can be inserted to the middle of the pattern points
- Editable font and color theme 

## Getting started

Import package and add CircularPattern to the widget tree.

<img src="https://gitlab.com/turkiye/flutter/circular_pattern/-/raw/b94150aa7fe2fee5ec5e8dce71ecbe0b8e05c0e6/preview.gif" width="300">

## Usage

An example usage can be found at `/example` folder. 

```dart
CircularPattern(
    onStart: () {
    // called when started drawing a new pattern
    },
    onComplete: (List<PatternDot> input) {
    // called when connected minimum amount of dots
    // input is a list of PatternDot
    },
    // dots is a list of PatternDot
    dots: const [
        PatternDot(value: '1'),
        PatternDot(value: '2'),
        PatternDot(value: '3'),
        PatternDot(value: '4'),
        PatternDot(value: '5'),
        PatternDot(value: '6'),
    ],

    //Optionally edit color and font themes with CircularPatternOptions()
    options: const CircularPatternOptions(),
),
```
