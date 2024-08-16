import SpriteKit

class VerticalCandle: SKSpriteNodeWithBounds {
    
    enum CandleSize {
        case double
        case triple
    }
    
    init(sizeMultiplier: CandleSize, size: CGSize) {
        var texture = SKTexture()
        if sizeMultiplier == .double {
            texture = SKTexture(imageNamed: "VerticalCandle2")
        } else {
            texture = SKTexture(imageNamed: "VerticalCandle3")
        }
        super.init(texture: texture, color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
