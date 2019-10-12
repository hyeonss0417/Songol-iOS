//
//  Coordinatable.swift
//  Songol-E
//
//  Created by 최민섭 on 12/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

protocol Coordinatable {
    func activate()
}

class LoginCoordinator: Coordinatable {
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func activate() {
        window?.rootViewController? = LoginViewController.instantiate(storyboard: .login)
    }
}

class MainCoordinator: Coordinatable {
    var navigationController: UINavigationController?
    
    init() {
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func activate() {
        guard let window = UIApplication.shared.windows.first else {return}
        window.rootViewController? = SWRevealViewController.instantiate(storyboard: .main)
    }
}

class CheckAuthCoordinator: Coordinatable {
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func activate() {
        let target = CheckAuthViewController.instantiate(storyboard: .login)
        target.coordinator = self
        window?.rootViewController? = target
    }
}

extension CheckAuthCoordinator: CheckAuthCoordinatorDelegate {
    func coordinateMain() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.activate()
    }
    
    func coordinateLogin() {
        let loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator.activate()
    }
}
