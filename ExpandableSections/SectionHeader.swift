//
//  SectionHeader.swift
//  ExpandableSections
//
//  Created by leonid on 21/03/2019.
//  Copyright © 2019 LLU. All rights reserved.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = String(describing: self)
    
    private lazy var tap: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap))
    }()
    
    //блок, который выполняется по нажатию (можешь заменить на делегирование, если хочешь, тогда не забудь сделать делегат weak)
    var onTap: (() -> Void)?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func handleTap() {
        //вызов блока
        onTap?()
    }
}
