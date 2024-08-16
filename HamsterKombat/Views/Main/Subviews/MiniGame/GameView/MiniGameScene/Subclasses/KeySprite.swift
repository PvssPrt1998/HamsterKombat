import SpriteKit

class KeySprite: SKSpriteNodeWithBounds {
    
    init(size: CGSize) {
        super.init(texture: SKTexture(imageNamed: "Key"), color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
