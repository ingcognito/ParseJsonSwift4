//
//  Reddit.swift
//  CSExercise
//
//  Created by mx-mac01 on 2018-01-23.
//  Copyright © 2018 Noah.Ing. All rights reserved.
//

import UIKit

struct RedditJSON: Decodable {
    let data: ParentData
}

struct ParentData: Decodable {
    let children: [Child]
}

struct Child: Decodable {
    let data: ChildData
}

struct ChildData : Decodable {
    let title: String
}
