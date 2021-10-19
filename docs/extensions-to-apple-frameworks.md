# Extensions to Apple Frameworks

ARHeadsetKit includes enhancements to Metal, simd, Core Text, and Core Video that improve usability and make optimization easier.

Metal:
- Array and integer literal initializers for `MTLSize`, `MTLOrigin`, and `MTLCoordinate2D`
- Debug labels for Metal resources that disappear in a release build to maximize performance
- Command buffers that automatically log detailed errors when using a debug build. Some of the error data can only be accessed when shader validation is enabled.
- [`MTLLayeredBuffer`](/articles/layered-buffer.md), which conserves memory by combining several small buffers into one contiguous allocation

simd:
- Optimized utility functions for working with affine transforms (much better than the Objective-C math utilities Apple ships with their Metal sample code)
- Half-precision vector and matrix types for writing to GPU data structures on the CPU
- Packed 3-wide vectors such as `simd_packed_float3`
- Conversion between single and half-precision vectors/matrices, but not arithmetic operations on them
- Performing multiple dot products at once to maximize vectorization and utilization of out-of-order execution
- Overloads to `fma(_:_:_:)` that automatically promote scalars to vectors
- High-level versions of SIMD math functions (e.g. `cos(_:)` instead of `__tg_cos(_:)`) that are compatible with iOS 14

Core Text and Core Video:
- High-level wrappers over C-style reference types, replacing verbose functions with properties and methods

Although these enhancements may seem more appropriate as part of an separate framework, they are bundled with ARHeadsetKit. Using them does not require configuring the Info.plist for an AR app. Half-precision vectors/matrices are only available on iOS and Apple Silicon Macs.