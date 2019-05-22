import UIKit
import SpriteKit

// средний сегмент змеи
class SnakeBodyPart: SKShapeNode {
    let diameter = 10
    // конструктор для отрисовки
    init(atPoint point: CGPoint) {
        super.init()
        // рисуем круглый элемент
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diameter), height: CGFloat(diameter))).cgPath
        // заливаем зеленым
        fillColor = UIColor.green
        // рамка
        strokeColor = UIColor.green
        // ширина рамки
        lineWidth = 5
        self.position = point
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

