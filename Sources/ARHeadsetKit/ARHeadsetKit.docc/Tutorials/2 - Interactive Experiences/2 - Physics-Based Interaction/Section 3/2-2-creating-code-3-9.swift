import ARHeadsetKit

struct Cube {
    var location: simd_float3
    var orientation: simd_quatf
    var sideLength: Float
    
    var velocity: simd_float3?
    var angularVelocity: simd_quatf?
    
    var isHighlighted = false
    var object: ARObject!
    var normalObject: ARObject!
    
    init(location: simd_float3,
         orientation: simd_quatf,
         sideLength: Float)
    {
        self.location = location
        self.orientation = orientation
        self.sideLength = sideLength
        
        object = getObject()
    }
    
    func getObject() -> ARObject {
        var color: simd_float3
        
        if isHighlighted {
            color = [0.6, 0.8, 1.0]
        } else {
            color = [0.2, 0.5, 0.7]
        }
        
        return ARObject(shapeType: .cube,
                        position: location,
                        orientation: orientation,
                        scale: .init(repeating: sideLength),
                        
                        color: color)
    }
    
    func render(centralRenderer: CentralRenderer) {
        centralRenderer.render(object: object)
    }
}

extension Cube {
    
    func trace(ray: RayTracing.Ray) -> Float? {
        guard velocity == nil, angularVelocity == nil else {
            return nil
        }
        
        return object.trace(ray: ray)
    }
    
    mutating func update() {
        defer {
            object = getObject()
        }
        
        guard let velocity = velocity,
              let angularVelocity = angularVelocity else {
            return
        }
        
        location += velocity / 60
        
        let angle = angularVelocity.angle / 60
        let axis  = angle == 0 ? [0, 1, 0] : angularVelocity.axis
        
        let rotation = simd_quatf(angle: angle, axis: axis)
        orientation = rotation * orientation
    }
    
}
