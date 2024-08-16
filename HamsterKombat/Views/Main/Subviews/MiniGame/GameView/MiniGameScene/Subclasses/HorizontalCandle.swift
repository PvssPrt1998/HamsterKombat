import SpriteKit

class HorizontalCandle: SKSpriteNodeWithBounds {
    
    enum CandleSize {
        case double
        case triple
    }
    
    init(sizeMultiplier: CandleSize, size: CGSize) {
        var texture = SKTexture()
        if sizeMultiplier == .double {
            texture = SKTexture(imageNamed: "HorizontalBlueCandle2")
        } else {
            texture = SKTexture(imageNamed: "HorizontalBlueCandle3")
        }
        super.init(texture: texture, color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
