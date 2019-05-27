import UIKit
import SpriteKit

// змейка
class Snake: SKShapeNode {
    //скорость перемещения
    let moveSpeed = 125.0
    // угол для расчета направления
    var angle: CGFloat = 0.0
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
    
    // перемещаем змейку
    func move() {
        // проверка наличия
        guard !body.isEmpty else {return}
        // перемещаем голову
        let head = body[0]
        moveHead(head)
        // перемещаем все сегменты тела
        for index in (0..<body.count) where index > 0 {
            let previousBodyPart = body[index - 1]
            let currentBodyPart = body[index]
            moveBodyPart(previousBodyPart, c: currentBodyPart)
        }
    }
    // перемещаем голову
    func moveHead(_ head: SnakeBodyPart) {
        // рассчитываем смещение точки
        let dx = CGFloat(moveSpeed) * sin(angle)
        let dy = CGFloat(moveSpeed) * cos(angle)
        // смещаем точку назначения головы
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        // действие перемещения головы
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        // запуск дейсвия перемещения
        head.run(moveAction)
    }
    // перемещаем сегмент змеи
    func moveBodyPart (_ p: SnakeBodyPart, c: SnakeBodyPart){
        // перемещаем текущий элемент к предыдущему
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1)
        // запуск действия перемещения
        c.run(moveAction)
    }
    
    //  поворот по часовой стрелке
    func moveClockwise(){
        // смещаем угол на 45 градусов
        angle += CGFloat(Double.pi/2)
    }
    
    // поворот против часовой стрелки
    func movecounterClockwise(){
        angle -= CGFloat(Double.pi/2)
    }
}
