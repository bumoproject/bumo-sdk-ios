# Bumo IOS SDK

## Introduction
IOS developers can easily operate Bumo blockchain via the Bumo IOS SDK. And you can complete the installation of the SDK by downloading the framework package in a few minutes.

1. [docs](/docs) are the usage documentations for the Bumo IOS SDK.
2. [examples](/examples) are some examples of a project.
3. [libs](/libs) is the framework package for the Bumo IOS SDK.
4. [src](/src)  is the source code for the Bumo IOS SDK.

## Environment

ios 8.0 or above.

## Installation

Step 1：Drag the sdk_ios.framework in libs to your project, and select "Copy items if needed".

Step 2: Add "libc++.tbd" in "Link Binary With Libraries" of "Build Phases".

Step 3: Set "-ObjC" in "Other Linker Flags" of "Build Setting".

Step 4: Add "#import <sdk_ios/sdk_ios.h>" in your project.

## Example project
Bumo IOS SDK provides rich examples for developers' reference

[Sample document entry](docs/SDK_CN.md "")
