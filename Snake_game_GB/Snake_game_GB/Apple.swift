import UIKit
import SpriteKit

// яблоко
class Apple: SKShapeNode {
    // определяем, как яблоко отрисовывается
    convenience init(position: CGPoint) {
        self.init()
        // рисуем круг
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        // заливаем его красным
        fillColor = UIColor.red
        // рамка
        strokeColor = UIColor.orange
        // ширина рамки
        lineWidth = 3
        self.position = position
        // добавляем физическое тело, которое совпадает с изображением
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center: CGPoint(x: 5, y: 5))
        // категория яблоко
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    }
}

