//
//  AddViewController.swift
//  You&I
//
//  Created by 최지철 on 2023/07/02.
//

import UIKit
import SnapKit
import Then
import PanModal
class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
}
extension AddViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(450)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
}
