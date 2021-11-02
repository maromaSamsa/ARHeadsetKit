import ARHeadsetKit
import Metal

class GameRenderer {
    unowned let renderer: MainRenderer
    
    var cubeRenderer: CubeRenderer!
    
    required init(renderer: MainRenderer, library: MTLLibrary!) {
        self.renderer = renderer
        
        renderer.canInteractWhileFlying = true
        
        cubeRenderer = CubeRenderer(gameRenderer: self)
    }
    
    func drawArrow(ray: RayTracing.Ray, progress: Float) {
        let arrowStart = ray.origin
        let arrowEnd   = ray.project(progress: progress)
        
        let arrowDirection = normalize(ray.direction)
        
        let tipStart = arrowEnd - 0.1 * arrowDirection
        let color = simd_float3(repeating: 0.8)
        
        if let tip = ARObject(roundShapeType: .cone,
                              bottomPosition: tipStart,
                              topPosition: arrowEnd,
                              diameter: 0.07,
                              
                              color: color)
        {
            centralRenderer.render(object: tip)
        }
        
        if distance(arrowStart, arrowEnd) > 0.1,
           let line = ARObject(roundShapeType: .cylinder,
                               bottomPosition: arrowStart,
                               topPosition: tipStart,
                               diameter: 0.05,
                               
                               color: color)
        {
            centralRenderer.render(object: line)
        }
    }
}

protocol DelegateGameRenderer {
    var gameRenderer: GameRenderer { get }
    init(gameRenderer: GameRenderer)
}

extension DelegateGameRenderer {
    var renderer: MainRenderer { gameRenderer.renderer }
    var centralRenderer: CentralRenderer { renderer.centralRenderer }
}
