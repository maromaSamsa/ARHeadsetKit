import ARHeadsetKit

extension GameRenderer: CustomRenderer {
    
    func updateResources() {
        let mediumBlue: simd_float3 = [0.20, 0.50, 0.70]
        let lightBlue:  simd_float3 = [0.60, 0.80, 1.00]
        
        func makeCube(color: simd_float3) -> ARObject {
            .init(shapeType: .cube,
                  position: cubePosition,
                  scale: .init(repeating: 0.2),
                  
                  color: color)
        }
        
        var object = makeCube(color: mediumBlue)
        
        if let interactionRay = renderer.interactionRay,
           object.trace(ray: interactionRay) != nil {
            
        }
        
        centralRenderer.render(object: object)
    }
    
    func drawGeometry(renderEncoder: ARMetalRenderCommandEncoder) {
        
    }
    
}
