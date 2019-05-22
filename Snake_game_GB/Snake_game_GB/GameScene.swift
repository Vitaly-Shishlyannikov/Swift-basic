//
//  GameScene.swift
//  Snake_game_GB
//
//  Created by Vitalik on 21.05.2019.
//  Copyright © 2019 Vit. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // добавляем змею на сцену
    var snake: Snake?
    
    // вызывается при первом запуске сцены
    override func didMove(to view: SKView) {
        
        // цвет фона сцены
        backgroundColor = SKColor.gray
        // вектор и сила гравитации
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        // поддержка физики
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        // выключаем внешние воздействия на игру
        self.physicsBody?.allowsRotation = false
        // отображение отладочной информации
        view.showsPhysics = true
        
        //  делаем сцену делегатом соприконсовений
        self.physicsWorld.contactDelegate = self
        
        // устанавливаем категорию взаимодействия с другими объектами
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        // устанавливаем категории, с которыми будут пересекаться края сцены
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        
        // поворот против часовой стрелки
        // создаем ноду(объект)
        let counterClockwiseButton = SKShapeNode()
        // задаем круглую форму
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        // указываем координаты размещения
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        // цвет заливки
        counterClockwiseButton.fillColor = UIColor.white
        // цвет рамки
        counterClockwiseButton.strokeColor = UIColor.black
        // толщина рамки
        counterClockwiseButton.lineWidth = 6
        // имя объекта для взаимодействия
        counterClockwiseButton.name = "counterClockwiseButton"
        // добавляем кнопку на сцену
        self.addChild(counterClockwiseButton)
        
        // поворот по часовой стрелке
        // создаем ноду(объект)
        let сlockwiseButton = SKShapeNode()
        // задаем круглую форму
        сlockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        // указываем координаты размещения
        сlockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        // цвет заливки
        сlockwiseButton.fillColor = UIColor.white
        // цвет рамки
        сlockwiseButton.strokeColor = UIColor.black
        // толщина рамки
        сlockwiseButton.lineWidth = 6
        // имя объекта для взаимодействия
        сlockwiseButton.name = "сlockwiseButton"
        // добавляем кнопку на сцену
        self.addChild(сlockwiseButton)
        
        // создание яблока в случайном месте при старте игры
        createApple()
        
        // создание змеи в центре и добавление ее на сцену
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
    }
    
    // вызывается при нажатии на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // перебираем точки касания пальцем
        for touch in touches {
            // определяем координаты касания
            let touchLocation = touch.location(in: self)
            // проверяем, есть ли в месте касания объект, кнопка
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "сlockwiseButton" else {
                return
            }
            // красим кнопку
            touchedNode.fillColor = .blue
            if touchedNode.name == "counterClockwiseButton" {
                snake!.movecounterClockwise()
            } else if touchedNode.name == "сlockwiseButton" {
                snake!.moveClockwise()
            }
        }
    }

    // вызывается при отпускании пальца от экрана
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // все то же самое при отпускании пальца
        for touch in touches {
            // определяем координаты отпускания
            let touchLocation = touch.location(in: self)
            // проверяем, есть ли в месте отпускания объект, кнопка
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "counterClockwiseButton" || touchedNode.name == "сlockwiseButton" else {
                    return
            }
            // возвращаем цвет кнопки
            touchedNode.fillColor = .white
        }
    }
    
    // вызывается при обрыве нажатия
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    // вызывается при обработке кадров сцены
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    
    // создание яблока в случайной точке сцены
    func createApple(){
        // генерация случайной точки на экране
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5))+1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5))+1)
        // создаем яблоко
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        // добавляем яблоко на сцену
        self.addChild(apple)
    }
}

// расширение протоколом для обработки соприкосновений
extension GameScene: SKPhysicsContactDelegate {
    // метод отслеживания начала столкновения
    func didBegin(_ contact: SKPhysicsContact) {
        // логическая сумма масок соприкоснувшихся объектов
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        // вычитаем из суммы голову змеи, и остается маска второго объекта
        let collisionObject = bodies ^ CollisionCategories.SnakeHead
        // разбираем столкновения
        switch collisionObject {
            // столкновение с яблоком
            case CollisionCategories.Apple:
                // яблоко - один из 2 соприкоснувшихся объектов, проверяем, какой именно
                let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
                // добавляем к змее еще 1 секцию
                snake?.addBodyPart()
                // удаляем съеденное яблоко со сцены
                apple?.removeFromParent()
                // создаем новое яблоко
                createApple()
            // столкновение со стеной
            case CollisionCategories.EdgeBody, CollisionCategories.SnakeHead:
                let scene = GameScene(size: self.size)
                let animation = SKTransition.crossFade(withDuration: 1)
                self.view?.presentScene(scene, transition: animation)
            default:
                break
        }
    }
}

// пересечение объектов
struct CollisionCategories {
    // тело змеи
    static let Snake: UInt32 = 0x1 << 0
    // голова змеи
    static let SnakeHead: UInt32 = 0x1 << 1
    // яблоко
    static let Apple: UInt32 = 0x1 << 2
    // край сцены(экрана)
    static let EdgeBody: UInt32 = 0x1 << 3
}

