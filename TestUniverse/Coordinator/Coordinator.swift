//
//  Coordinator.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var rootViewController: UIViewController? { get }
    
    func showOnboarding()
}


final class Coordinator {
    
    private let navigationController: UINavigationController
  
    
    init(navigationController: NavigationVC) {
        self.navigationController = navigationController
    }
    
    
}

extension Coordinator: CoordinatorProtocol {
    var rootViewController: UIViewController? {
        navigationController
    }
    
    func showOnboarding() {
        let viewModel = OnboardingViewModel()
        let onboardingVC = OnboardingViewController(coordinator: self, viewModel: viewModel)
        navigationController.pushViewController(onboardingVC, animated: true)
    }
    
   
}
