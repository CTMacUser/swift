// RUN: %empty-directory(%t)
// RUN: %target-swift-frontend -swift-version 5 -enable-library-evolution -module-name test -emit-module -o %t/test.swiftmodule -emit-module-interface-path -  -enable-experimental-feature TransferringArgsAndResults %s | %FileCheck %s

public class NonSendableKlass {}

// CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
// CHECK-NEXT: public func transferArgTest(_ x: transferring test.NonSendableKlass)
// CHECK-NEXT: #else
// CHECK-NEXT: public func transferArgTest(_ x: test.NonSendableKlass)
// CHECK-NEXT: #endif
public func transferArgTest(_ x: transferring NonSendableKlass) {}

// CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
// CHECK-NEXT: public func transferResultTest() -> transferring test.NonSendableKlass
// CHECK-NEXT: #else
// CHECK-NEXT: public func transferResultTest() -> test.NonSendableKlass
// CHECK-NEXT: #endif
public func transferResultTest() -> transferring NonSendableKlass { fatalError() }

// CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
// CHECK-NEXT: public func transferArgAndResultTest(_ x: test.NonSendableKlass, _ y: transferring test.NonSendableKlass, _ z: test.NonSendableKlass) -> transferring test.NonSendableKlass
// CHECK-NEXT: #else
// CHECK-NEXT: public func transferArgAndResultTest(_ x: test.NonSendableKlass, _ y: test.NonSendableKlass, _ z: test.NonSendableKlass) -> test.NonSendableKlass
// CHECK-NEXT: #endif
public func transferArgAndResultTest(_ x: NonSendableKlass, _ y: transferring NonSendableKlass, _ z: NonSendableKlass) -> transferring NonSendableKlass { fatalError() }

// CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
// CHECK-NEXT: public func argEmbeddedInType(_ fn: (transferring test.NonSendableKlass) -> ())
// CHECK-NEXT: #else
// CHECK-NEXT: public func argEmbeddedInType(_ fn: (test.NonSendableKlass) -> ())
// CHECK-NEXT: #endif
public func argEmbeddedInType(_ fn: (transferring NonSendableKlass) -> ()) {}

// CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
// CHECK-NEXT: public func resultEmbeddedInType(_ fn: () -> transferring test.NonSendableKlass)
// CHECK-NEXT: #else
// CHECK-NEXT: public func resultEmbeddedInType(_ fn: () -> test.NonSendableKlass)
// CHECK-NEXT: #endif
public func resultEmbeddedInType(_ fn: () -> transferring NonSendableKlass) {}

// CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
// CHECK-NEXT: public func argAndResultEmbeddedInType(_ fn: (test.NonSendableKlass, transferring test.NonSendableKlass, test.NonSendableKlass) -> transferring test.NonSendableKlass)
// CHECK-NEXT: #else
// CHECK-NEXT: public func argAndResultEmbeddedInType(_ fn: (test.NonSendableKlass, test.NonSendableKlass, test.NonSendableKlass) -> test.NonSendableKlass)
// CHECK-NEXT: #endif
public func argAndResultEmbeddedInType(_ fn: (NonSendableKlass, transferring NonSendableKlass, NonSendableKlass) -> transferring NonSendableKlass) {}

public class TestInKlass {
  // CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
  // CHECK-NEXT: public func testKlassArg(_ x: transferring test.NonSendableKlass)
  // CHECK-NEXT: #else
  // CHECK-NEXT: public func testKlassArg(_ x: test.NonSendableKlass)
  // CHECK-NEXT: #endif
  public func testKlassArg(_ x: transferring NonSendableKlass) { fatalError() }

  // CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
  // CHECK-NEXT: public func testKlassResult() -> transferring test.NonSendableKlass
  // CHECK-NEXT: #else
  // CHECK-NEXT: public func testKlassResult() -> test.NonSendableKlass
  // CHECK-NEXT: #endif
  public func testKlassResult() -> transferring NonSendableKlass { fatalError() }

  // CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
  // CHECK-NEXT: public func testKlassArgAndResult(_ x: test.NonSendableKlass, _ y: transferring test.NonSendableKlass, z: test.NonSendableKlass) -> transferring test.NonSendableKlass
  // CHECK-NEXT: #else
  // CHECK-NEXT: public func testKlassArgAndResult(_ x: test.NonSendableKlass, _ y: test.NonSendableKlass, z: test.NonSendableKlass) -> test.NonSendableKlass
  // CHECK-NEXT: #endif
  public func testKlassArgAndResult(_ x: NonSendableKlass, _ y: transferring NonSendableKlass, z: NonSendableKlass) -> transferring NonSendableKlass { fatalError() }
}

public struct TestInStruct {
  // CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
  // CHECK-NEXT: public func testKlassArg(_ x: transferring test.NonSendableKlass)
  // CHECK-NEXT: #else
  // CHECK-NEXT: public func testKlassArg(_ x: test.NonSendableKlass)
  // CHECK-NEXT: #endif
  public func testKlassArg(_ x: transferring NonSendableKlass) { fatalError() }

  // CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
  // CHECK-NEXT: public func testKlassResult() -> transferring test.NonSendableKlass
  // CHECK-NEXT: #else
  // CHECK-NEXT: public func testKlassResult() -> test.NonSendableKlass
  // CHECK-NEXT: #endif
  public func testKlassResult() -> transferring NonSendableKlass { fatalError() }

  // CHECK-LABEL: #if compiler(>=5.3) && $TransferringArgsAndResults
  // CHECK-NEXT: public func testKlassArgAndResult(_ x: test.NonSendableKlass, _ y: transferring test.NonSendableKlass, z: test.NonSendableKlass) -> transferring test.NonSendableKlass
  // CHECK-NEXT: #else
  // CHECK-NEXT: public func testKlassArgAndResult(_ x: test.NonSendableKlass, _ y: test.NonSendableKlass, z: test.NonSendableKlass) -> test.NonSendableKlass
  // CHECK-NEXT: #endif
  public func testKlassArgAndResult(_ x: NonSendableKlass, _ y: transferring NonSendableKlass, z: NonSendableKlass) -> transferring NonSendableKlass { fatalError() }
}
