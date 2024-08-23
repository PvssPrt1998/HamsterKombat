import SpriteKit
import GameplayKit

class GameScene: SKScene, ObservableObject {
    
    @Published var win = false
    
    let squareWidth: CGFloat
    
    var key: KeySprite
    var Hcandle21: HorizontalCandle
    var Hcandle22: HorizontalCandle
    var Hcandle23: HorizontalCandle
    var Hcandle24: HorizontalCandle
    var Hcandle31: HorizontalCandle
    var vCandle31: VerticalCandle
    var vCandle32: VerticalCandle
    var vCandle21: VerticalCandle
    var vCandle22: VerticalCandle
    var vCandle23: VerticalCandle
    var vCandle24: VerticalCandle
    var movableNode: SKSpriteNodeWithBounds?
    
    var touchXOffset: CGFloat = 0
    
    override init(size: CGSize) {
        squareWidth = size.width/6
        Hcandle21 = HorizontalCandle(sizeMultiplier: .double, size: CGSize(width: squareWidth * 2, height: squareWidth))
        Hcandle22 = HorizontalCandle(sizeMultiplier: .double, size: CGSize(width: squareWidth * 2, height: squareWidth))
        Hcandle23 = HorizontalCandle(sizeMultiplier: .double, size: CGSize(width: squareWidth * 2, height: squareWidth))
        Hcandle24 = HorizontalCandle(sizeMultiplier: .double, size: CGSize(width: squareWidth * 2, height: squareWidth))
        Hcandle31 = HorizontalCandle(sizeMultiplier: .triple, size: CGSize(width: squareWidth * 3, height: squareWidth))
        vCandle31 = VerticalCandle(sizeMultiplier: .triple, size: CGSize(width: squareWidth, height: squareWidth * 3))
        vCandle32 = VerticalCandle(sizeMultiplier: .triple, size: CGSize(width: squareWidth, height: squareWidth * 3))
        vCandle21 = VerticalCandle(sizeMultiplier: .double, size: CGSize(width: squareWidth, height: squareWidth * 2))
        vCandle22 = VerticalCandle(sizeMultiplier: .double, size: CGSize(width: squareWidth, height: squareWidth * 2))
        vCandle23 = VerticalCandle(sizeMultiplier: .double, size: CGSize(width: squareWidth, height: squareWidth * 2))
        vCandle24 = VerticalCandle(sizeMultiplier: .double, size: CGSize(width: squareWidth, height: squareWidth * 2))
        key = KeySprite(size: CGSize(width: squareWidth * 2, height: squareWidth))
        super.init(size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupBackground()
        setupHCandles()
        setupVCandles()
        setupKey()
        calculateRangeH()
        calculateRangeV()
    }
    
    private func setupBackground() {
        let background = SKSpriteNode(imageNamed: "MiniGameBoard")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: size.width, height: size.width)
        background.zPosition = 0
        self.addChild(background)
    }
    private func setupKey() {
        key.zPosition = 1
        key.size = CGSize(width: squareWidth * 2 - 2, height: squareWidth - 2)
        key.position = CGPoint(x: squareWidth + 2 * squareWidth + ((squareWidth/2) * (CGFloat(2) - 2)) + 1, y: squareWidth/2 + squareWidth * 3 + 1)
        addChild(key)
    }
    
    private func setupHCandles() {
        setupHCandle(Hcandle21, squaresFromBottom: 3, squaresFromLeft: 0, multiplier: 2)
        setupHCandle(Hcandle22, squaresFromBottom: 4, squaresFromLeft: 0, multiplier: 2)
        setupHCandle(Hcandle23, squaresFromBottom: 2, squaresFromLeft: 3, multiplier: 2)
        setupHCandle(Hcandle24, squaresFromBottom: 5, squaresFromLeft: 4, multiplier: 2)
        setupHCandle(Hcandle31, squaresFromBottom: 0, squaresFromLeft: 2, multiplier: 3)
        
    }
    
    private func setupVCandles() {
        setupVCandle(vCandle31, squaresFromBottom: 0, squaresFromLeft: 5, multiplier: 3)
        setupVCandle(vCandle32, squaresFromBottom: 0, squaresFromLeft: 1, multiplier: 3)
        setupVCandle(vCandle21, squaresFromBottom: 1, squaresFromLeft: 2, multiplier: 2)
        setupVCandle(vCandle22, squaresFromBottom: 4, squaresFromLeft: 2, multiplier: 2)
        setupVCandle(vCandle23, squaresFromBottom: 3, squaresFromLeft: 4, multiplier: 2)
        setupVCandle(vCandle24, squaresFromBottom: 3, squaresFromLeft: 5, multiplier: 2)
    }
    
    private func setupHCandle(_ candle: SKSpriteNode, squaresFromBottom: Int, squaresFromLeft: Int, multiplier: Int) {
        candle.position = CGPoint(x: squareWidth + CGFloat(squaresFromLeft) * squareWidth + ((squareWidth/2) * (CGFloat(multiplier) - 2)) + 1, y: squareWidth/2 + squareWidth * CGFloat(squaresFromBottom) + 1)
        candle.size = CGSize(width: squareWidth * CGFloat(multiplier) - 2, height: squareWidth - 2)
        candle.zPosition = 1
        addChild(candle)
    }
    
    private func setupVCandle(_ candle: SKSpriteNode, squaresFromBottom: Int, squaresFromLeft: Int, multiplier: Int) {
        candle.position = CGPoint(x: squareWidth/2 + squareWidth * CGFloat(squaresFromLeft) + 1, y: squareWidth + CGFloat(squaresFromBottom) * squareWidth + ((squareWidth/2) * CGFloat(multiplier - 2)) + 1)
        candle.size = CGSize(width: squareWidth - 2, height: squareWidth * CGFloat(multiplier) - 2)
        candle.zPosition = 1
        addChild(candle)
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if contains(point: location, node: Hcandle21) {
                touchXOffset = location.x - Hcandle21.position.x
                movableNode = Hcandle21
            } else
            if contains(point: location, node: Hcandle22) {
                touchXOffset = location.x - Hcandle22.position.x
                movableNode = Hcandle22
            } else
            if contains(point: location, node: Hcandle23) {
                touchXOffset = location.x - Hcandle23.position.x
                movableNode = Hcandle23
            } else
            if contains(point: location, node: Hcandle24) {
                touchXOffset = location.x - Hcandle24.position.x
                movableNode = Hcandle24
            } else
            if contains(point: location, node: Hcandle31) {
                touchXOffset = location.x - Hcandle31.position.x
                movableNode = Hcandle31
            } else
            if contains(point: location, node: vCandle31) {
                touchXOffset = location.y - vCandle31.position.y
                movableNode = vCandle31
            } else
            if contains(point: location, node: key) {
                touchXOffset = location.x - key.position.x
                movableNode = key
            } else
            if contains(point: location, node: vCandle21) {
                touchXOffset = location.y - vCandle21.position.y
                movableNode = vCandle21
            } else
            if contains(point: location, node: vCandle32) {
                touchXOffset = location.y - vCandle32.position.y
                movableNode = vCandle32
            } else
            if contains(point: location, node: vCandle22) {
                touchXOffset = location.y - vCandle22.position.y
                movableNode = vCandle22
            } else
            if contains(point: location, node: vCandle23) {
                touchXOffset = location.y - vCandle23.position.y
                movableNode = vCandle23
            } else
            if contains(point: location, node: vCandle24) {
                touchXOffset = location.y - vCandle24.position.y
                movableNode = vCandle24
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            if isVertical() {
                movableNode!.position.y = touch.location(in: self).y - touchXOffset
            } else {
                movableNode!.position.x = touch.location(in: self).x - touchXOffset
            }
        }
    }
    
    private func calculateRangeV(_ ignoredSprite: SKSpriteNode? = nil) {
        var sprites = [vCandle31, vCandle32, vCandle21, vCandle22, vCandle23, vCandle24]
        if let ignoredSprite = ignoredSprite {
            sprites.removeAll { $0 === ignoredSprite }
        }
        sprites.forEach { sprite in
            calculateRangeV(for: sprite)
        }
    }
    
    private func calculateRangeH(_ ignoredSprite: SKSpriteNodeWithBounds? = nil) {
        var sprites: Array<SKSpriteNodeWithBounds> = [Hcandle21, Hcandle22, Hcandle23, Hcandle24, Hcandle31, key]
        if let ignoredSprite = ignoredSprite {
            sprites.removeAll { $0 === ignoredSprite }
        }
        sprites.forEach { sprite in
            calculateRangeH(for: sprite)
        }
    }
    
    private func calculateRangeV(for sprite: SKSpriteNodeWithBounds) {
        var sprites = [Hcandle21, Hcandle22, Hcandle23, Hcandle24, Hcandle31, vCandle31, key, vCandle32, vCandle21, vCandle22, vCandle23, vCandle24]
        sprites.removeAll { $0 === sprite }
        
        let rangeY = SKRange(lowerLimit: sprite.size.height / 2 + 1,
                             upperLimit: size.height - sprite.size.height / 2 - 1)
        let rangeX = SKRange(lowerLimit: sprite.size.width/2 + 1, upperLimit: size.width - sprite.size.width/2 - 1)
        
        let left = sprite.position.x - sprite.size.width / 2
        let right = sprite.position.x + sprite.size.width / 2
        
        var bestUpperLimit: CGFloat = rangeY.upperLimit
        var bestLowerLimit: CGFloat = rangeY.lowerLimit
        
        sprites.forEach { otherSprite in
            let otherSpriteBottom = otherSprite.position.y - otherSprite.size.height / 2
            let otherSpriteLeft = otherSprite.position.x - otherSprite.size.width / 2
            let otherSpriteTop = otherSprite.position.y + otherSprite.size.height / 2
            let otherSpriteRight = otherSprite.position.x + otherSprite.size.width / 2
            
            //Conditions
            let rightPointInRange = otherSpriteRight <= right && otherSpriteRight > left
            let leftPointInRange = otherSpriteLeft >= left && otherSpriteLeft < right
            let rangeBetweenRightAndLeft = right <= otherSpriteRight && otherSpriteLeft <= left
            if rangeBetweenRightAndLeft || leftPointInRange || rightPointInRange {
                if sprite.position.y > otherSprite.position.y { //спрайт для которого высчитываем все выше другого
                    if otherSpriteTop + sprite.size.height / 2 > bestLowerLimit {
                        rangeY.lowerLimit = otherSpriteTop + sprite.size.height / 2 + 1
                        bestLowerLimit = rangeY.lowerLimit
                    }
                }
                if sprite.position.y < otherSprite.position.y { //Ниже
                    if bestUpperLimit > otherSpriteBottom - sprite.size.height / 2 {
                        rangeY.upperLimit = otherSpriteBottom - sprite.size.height / 2 - 1
                        bestUpperLimit = rangeY.upperLimit
                    }
                }
            }
        }
        
        sprite.upperBound = rangeY.upperLimit
        sprite.lowerBound = rangeY.lowerLimit
        
        let xConstraint = SKConstraint.positionX(rangeX)
        let yConstraint = SKConstraint.positionY(rangeY)
        sprite.constraints = [xConstraint, yConstraint]
    }
    
    private func calculateRangeH(for sprite: SKSpriteNodeWithBounds) {
        
        var sprites = [Hcandle21, Hcandle22, Hcandle23, Hcandle24, Hcandle31, vCandle31, key, vCandle32, vCandle21, vCandle22, vCandle23, vCandle24]
        sprites.removeAll { $0 === sprite }
        
        let rangeY = SKRange(lowerLimit: squareWidth/2, upperLimit: size.height - squareWidth/2)
        let rangeX = SKRange(lowerLimit: sprite.size.width / 2, upperLimit: size.width - sprite.size.width / 2)
        let top = sprite.position.y + sprite.size.height / 2
        let bottom = sprite.position.y - sprite.size.height / 2
        sprites.forEach { otherSprite in
            let otherSpriteBottom = otherSprite.position.y - otherSprite.size.height / 2
            let otherSpriteLeft = otherSprite.position.x - otherSprite.size.width / 2
            let otherSpriteTop = otherSprite.position.y + otherSprite.size.height / 2
            let otherSpriteRight = otherSprite.position.x + otherSprite.size.width / 2
            
            //Conditions
            let bottomPointInRange = otherSpriteBottom < top && otherSpriteBottom >= bottom
            let topPointInRange = otherSpriteTop < top && otherSpriteTop > bottom
            let rangeBetweenTopAndBottom = top <= otherSpriteTop && bottom >= otherSpriteBottom
            
            if topPointInRange || bottomPointInRange || rangeBetweenTopAndBottom {
                
                if sprite.position.x > otherSpriteRight {
                    if (otherSpriteRight + sprite.size.width / 2) > rangeX.lowerLimit {
                        rangeX.lowerLimit = otherSpriteRight + sprite.size.width / 2 + 1
                    }
                }
                if sprite.position.x < otherSpriteLeft {
                    if rangeX.upperLimit >= otherSpriteLeft - sprite.size.width / 2 {
                        rangeX.upperLimit = otherSpriteLeft - sprite.size.width / 2 - 1
                    }
                }
            }
        }
        
        sprite.upperBound = rangeX.upperLimit
        sprite.lowerBound = rangeX.lowerLimit
        
        let xConstraint = SKConstraint.positionX(rangeX)
        let yConstraint = SKConstraint.positionY(rangeY)
        sprite.constraints = [xConstraint, yConstraint]
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if movableNode != nil {
            if movableNode! is VerticalCandle {
                if movableNode!.position.y > movableNode!.upperBound {
                    movableNode!.position.y = movableNode!.upperBound
                } else if movableNode!.position.y < movableNode!.lowerBound {
                    movableNode!.position.y = movableNode!.lowerBound
                }
            } else if movableNode! is HorizontalCandle {
                if movableNode!.position.x > movableNode!.upperBound {
                    movableNode!.position.x = movableNode!.upperBound
                } else if movableNode!.position.x < movableNode!.lowerBound {
                    movableNode!.position.x = movableNode!.lowerBound
                }
            } else if movableNode! is KeySprite {
                if movableNode!.position.x > movableNode!.upperBound {
                    movableNode!.position.x = movableNode!.upperBound
                } else if movableNode!.position.x < movableNode!.lowerBound {
                    movableNode!.position.x = movableNode!.lowerBound
                }
                if movableNode!.position.x >= size.width - squareWidth - 10 {
                    movableNode!.constraints = []
                    let action = SKAction.moveTo(x: size.width + squareWidth * 3, duration: 1)
                    movableNode!.run(action)
                    self.win = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.win = true
                    }
                    
                }
                   
                    
            }
            calculateRangeH(movableNode)
            calculateRangeV(movableNode)
        }
        touchXOffset = 0
        movableNode = nil
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if movableNode != nil {
            if movableNode! is VerticalCandle {
                if movableNode!.position.y > movableNode!.upperBound {
                    movableNode!.position.y = movableNode!.upperBound
                } else if movableNode!.position.y < movableNode!.lowerBound {
                    movableNode!.position.y = movableNode!.lowerBound
                }
            } else if movableNode! is HorizontalCandle {
                if movableNode!.position.x > movableNode!.upperBound {
                    movableNode!.position.x = movableNode!.upperBound
                } else if movableNode!.position.x < movableNode!.lowerBound {
                    movableNode!.position.x = movableNode!.lowerBound
                }
            } else if movableNode! is KeySprite {
                if movableNode!.position.x > movableNode!.upperBound {
                    movableNode!.position.x = movableNode!.upperBound
                } else if movableNode!.position.x < movableNode!.lowerBound {
                    movableNode!.position.x = movableNode!.lowerBound
                }
                if movableNode!.position.x >= size.width - squareWidth - 10 {
                    movableNode!.constraints = []
                    let action = SKAction.moveTo(x: size.width + squareWidth * 3, duration: 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.win = true
                    }
                    movableNode!.run(action)
                    
                }
            }
            calculateRangeH(movableNode)
            calculateRangeV(movableNode)
        }
        movableNode = nil
        touchXOffset = 0
    }
    
    func initialConstraints() {
        
    }
    
    func contains(point: CGPoint, node: SKSpriteNode) -> Bool {
        let nodePos = node.position
        
        if point.x >= (nodePos.x - node.size.width / 2) &&
            point.x <= (nodePos.x + node.size.width / 2) &&
            point.y >= (nodePos.y - node.size.height / 2) &&
            point.y <= (nodePos.y + node.size.height / 2)
        {
            return true
        } else {
            return false
        }
    }
    
    func isVertical() -> Bool {
        movableNode is VerticalCandle ? true : false
    }
}
