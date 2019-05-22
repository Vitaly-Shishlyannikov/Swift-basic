import UIKit
import SpriteKit

// змейка
class Snake: SKShapeNode {
    // массив с сегментами тела
    var body = [SnakeBodyPart]()
    // конструктор
    convenience init (atPoint point: CGPoint) {
        self.init()
        //  создадим голову
        let head = SnakeHead(atPoint: point)
        // добавим голову в массив
        body.append(head)
        // cделаем ее дочерним объектом
        addChild(head)
    }
    // метод для добавления элемента тела
    func addBodyPart () {
        // установим сегмент
        let newBodyPart = SnakeBodyPart(atPoint: body[0].position)
        // добавляем его в массив
        body.append(newBodyPart)
        // делаем дочерним объектом
        addChild(newBodyPart)
    }
}
