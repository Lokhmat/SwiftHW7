//
//  ActionButton.swift
//  splokhmatikovPW7
//
//  Created by Sergey Lokhmatikov on 30.01.2022.
//

import UIKit

class ActionButton : UIButton {
    
    init(frame: CGRect = .zero, color: UIColor, text: String){
        super.init(frame: frame)
        backgroundColor = color
        setTitle(text, for: .normal)
        layer.cornerRadius = 10
        setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
