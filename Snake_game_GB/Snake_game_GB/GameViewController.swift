
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // создаем экземпляр сцены
        let scene = GameScene(size: view.bounds.size)
        // получаем главную область экрана
        let skView = view as! SKView
        // включаем отображение FPS
        skView.showsFPS = true
        // отображение количества объектов на экране
        skView.showsNodeCount = true
        // включить произвольный порядок рендеринга объектов в узле
        skView.ignoresSiblingOrder = true
        // режим отображения сцены, растянуть на все доступное пространство
        scene.scaleMode = .resizeFill
        // добавляем сцену на экран
        skView.presentScene(scene)
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
