//
//  Intro.swift
//  IntroAnimation
//
//  Created by Coray SONG on 21/12/2022.
//

import SwiftUI

struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
}

var intros: [Intro] = [
    .init(imageName: "Image 1", title: "Relax"),
    .init(imageName: "Image 2", title: "Care"),
    .init(imageName: "Image 3", title: "Mood Dairy"),
]


// MARK: Dummy Text
let dummyText = "Lorem ipsum is simlly dummy text off the printing and typesetting industru. \nLorem Ipsum is dummy test."
