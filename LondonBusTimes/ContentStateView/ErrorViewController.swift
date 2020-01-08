//
//  ErrorView.swift
//  LondonBusTimes
//
//  Created by Ade Adegoke on 16/09/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var errors: DataSourceError?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.white.cgColor
        if let stringError = errors?.localizedDescription {
            errorMessageLabel.text = stringError
        }
    }
  
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.coordinator?.childDidFinish(self)
    }
    
    @IBAction private func backToContentStateView(_ sender: Any) {
        self.coordinator?.pushContentStateView()
    }
}

extension ErrorViewController: Storyboarded {}


