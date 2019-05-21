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
        counterClockwiseButton.lineWidth = 8
        // имя объекта для взаимодействия
        counterClockwiseButton.name = "counterClockwiseButton"
        
        // поворот по часовой стрелке
        // создаем ноду(объект)
        let сlockwiseButton = SKShapeNode()
        // задаем круглую форму
        сlockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        // указываем координаты размещения
        сlockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        // цвет заливки
        сlockwiseButton.fillColor = UIColor.white
        // цвет рамки
        сlockwiseButton.strokeColor = UIColor.black
        // толщина рамки
        сlockwiseButton.lineWidth = 8
        // имя объекта для взаимодействия
        сlockwiseButton.name = "сlockwiseButton"
    }
    
    // вызывается при нажатии на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        }
    
    // вызывается при отпускании пальца от экрана
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    // вызывается при обрыве нажатия
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    // вызывается при обработке кадров сцены
    override func update(_ currentTime: TimeInterval) {
    }
}
