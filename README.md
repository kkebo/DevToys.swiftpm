# DevToys for iPad

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://www.swift.org)
[![Swift Playground](https://img.shields.io/badge/Swift%20Playground-4.6-orange.svg)](https://itunes.apple.com/jp/app/swift-playground/id908519492)
![Platform](https://img.shields.io/badge/platform-ipados%20%7C%20ios-lightgrey.svg)
[![License](https://img.shields.io/github/license/kkebo/DevToys.swiftpm.svg)](LICENSE.txt)

This app is a SwiftUI reimplementation of [DevToys](https://devtoys.app), a Swiss Army Knife for developers, for iPadOS.

<img src="./screenshot.png" alt="screenshot" width="640">

## Features

- Converters
  - [ ] Cron Expression Parser [#107]
  - [ ] Date Converter
    - [x] Unix Timestamp
    - [ ] Other features [#119]
  - [ ] JSON Array to Table [#108]
  - [ ] JSON <> YAML Converter
    - [x] Basic features
    - [ ] Other features [#73]
  - [ ] Number Base Converter
    - [x] Basic features
    - [ ] Advanced mode [#131]
- Encoders / Decoders
  - [ ] Base64 Image Encoder / Decoder [#103]
  - [x] Base64 Text Encoder / Decoder
  - [ ] Certificate Decoder [#104]
  - [ ] GZip Compress / Decompress [#105]
  - [x] HTML Test Encoder / Decoder
  - [ ] JWT Encoder / Decoder
    - [x] Decoder
    - [ ] Encoder [#120]
  - [ ] QR Code Encoder / Decoder [#106]
  - [x] URL Encoder / Decoder
- Formatters
  - [ ] JSON Formatter
    - [x] Basic features
    - [ ] Sort properties [#124]
  - [ ] SQL Formatter [#109]
  - [ ] XML Formatter [#110]
- Generators
  - [ ] Hash / Checksum Generator
    - [x] MD5, SHA1, SHA256, SHA384, SHA512
    - [x] HMAC
    - [ ] Checksum [#122]
  - [ ] Lorem Ipsum Generator
    - [x] Lorem Ipsum
    - [ ] More text corpora [#129]
  - [ ] Password Generator [#111]
  - [x] UUID Generator
    - [x] v1, v4
    - [ ] v7 [#125]
- Graphic
  - [ ] Color Blindness Simulator [#112]
  - [ ] Image Converter [#113]
- Testers
  - [ ] JSONPath Tester [#114]
  - [ ] Regular Expression Tester [#41]
  - [ ] XML / XSD Tester [#115]
- Text
  - [ ] Text Escape / Unescape [#116]
  - [x] List Comparer
  - [ ] Markdown Preview
    - [x] Basic features
    - [ ] GitHub-flavored Markdown [#126]
  - [ ] Text Analyzer and Utilities [#117]
  - [ ] Text Comparer [#118]

[#41]: https://github.com/kkebo/DevToys.swiftpm/issues/41
[#73]: https://github.com/kkebo/DevToys.swiftpm/issues/73
[#103]: https://github.com/kkebo/DevToys.swiftpm/issues/103
[#104]: https://github.com/kkebo/DevToys.swiftpm/issues/104
[#105]: https://github.com/kkebo/DevToys.swiftpm/issues/105
[#106]: https://github.com/kkebo/DevToys.swiftpm/issues/106
[#107]: https://github.com/kkebo/DevToys.swiftpm/issues/107
[#108]: https://github.com/kkebo/DevToys.swiftpm/issues/108
[#109]: https://github.com/kkebo/DevToys.swiftpm/issues/109
[#110]: https://github.com/kkebo/DevToys.swiftpm/issues/110
[#111]: https://github.com/kkebo/DevToys.swiftpm/issues/111
[#112]: https://github.com/kkebo/DevToys.swiftpm/issues/112
[#113]: https://github.com/kkebo/DevToys.swiftpm/issues/113
[#114]: https://github.com/kkebo/DevToys.swiftpm/issues/114
[#115]: https://github.com/kkebo/DevToys.swiftpm/issues/115
[#116]: https://github.com/kkebo/DevToys.swiftpm/issues/116
[#117]: https://github.com/kkebo/DevToys.swiftpm/issues/117
[#118]: https://github.com/kkebo/DevToys.swiftpm/issues/118
[#119]: https://github.com/kkebo/DevToys.swiftpm/issues/119
[#120]: https://github.com/kkebo/DevToys.swiftpm/issues/120
[#122]: https://github.com/kkebo/DevToys.swiftpm/issues/122
[#124]: https://github.com/kkebo/DevToys.swiftpm/issues/124
[#125]: https://github.com/kkebo/DevToys.swiftpm/issues/125
[#126]: https://github.com/kkebo/DevToys.swiftpm/issues/126
[#129]: https://github.com/kkebo/DevToys.swiftpm/issues/129
[#131]: https://github.com/kkebo/DevToys.swiftpm/issues/131

## Target platforms

- iPadOS 18.1 or later
- iOS 18.1 or later
  
## Build requirements

- Swift Playground 4.6 or later (iPadOS 18.1 or later)
- Swift Playground 4.6 or later (macOS 14.0 or later)
- Xcode 16.1 or later (macOS 14.5 or later)

## Get Started

1. Clone this repository
    - To clone, I recommend using [Working Copy](https://workingcopyapp.com) or [a-Shell](https://holzschu.github.io/a-Shell_iOS/) (`lg2` command).
1. Open DevToys.swiftpm with Swift Playground
1. Run
