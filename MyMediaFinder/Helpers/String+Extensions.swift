//
//  String+Extensions.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation

extension String {
    
    func isValidQuery() -> Bool {
        let queryRegEx = "^[\\sA-Za-z0-9.-]{3,64}\\s*"

        let queryPred = NSPredicate(format:"SELF MATCHES %@", queryRegEx)
        return queryPred.evaluate(with: self)
    }
}
