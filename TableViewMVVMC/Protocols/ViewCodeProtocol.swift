//
//  ViewCodeProtocol.swift
//  TableViewMVVMC
//
//  Created by Saulo Oliveira on 04/12/22.
//

import Foundation

public protocol ViewCode {
    
    func buildViewHierarchy()
    
    func setupConstraints()
    
    func additionalSetup()
}

public extension ViewCode {
    
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() {
        //
    }
}
