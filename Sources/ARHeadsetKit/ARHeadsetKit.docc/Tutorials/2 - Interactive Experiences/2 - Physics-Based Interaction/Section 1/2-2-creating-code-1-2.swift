import ARHeadsetKit

struct Cube {
    var location: simd_float3
    var orientation: simd_quatf
    var sideLength: Float
    
    var object: ARObject!
    
    private func getObject() -> ARObject {
        .init(shapeType: .cube,
              position: location,
              orientation: orientation,
              scale: .init(repeating: sideLength))
    }
}
