//
//  filterView.swift
//  LibraryApp
//
//  Created by Anoop on 04/10/23.
//

import UIKit

class filterView: UIView {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commanInit()
    }
    
    required override init?(coder: NSCoder) {
        super.init(coder: coder)
        commanInit()
    }
    
    private func  commanInit() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        self.addSubview(scrollView)
        
        var scrollViewAnchor = [NSLayoutConstraint]()
        scrollViewAnchor.append(scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        scrollViewAnchor.append(scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0))
        scrollViewAnchor.append(scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))
        scrollViewAnchor.append(scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        NSLayoutConstraint.activate(scrollViewAnchor)
        
        var stackViewAnchor = [NSLayoutConstraint]()
        stackViewAnchor.append(stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0))
//        stackViewAnchor.append(stackView.bottomAnchor.constraint(equalTo: scrollView.leadingAnchor))
        stackViewAnchor.append(stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0))
        stackViewAnchor.append(stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0))
        
        
    }

}
