//
//  Challenges.swift
//  PowerHourFinal
//
//  Created by Morten Stulen on 17.02.15.
//  Copyright (c) 2015 Morten Stulen. All rights reserved.
//

import Foundation
import UIKit

//var challengeArray: [String] = ["Sniff the breath of everyone in the room and say who has the worst.", "Kris suger"]
var hardChallengeArray: [String] = ["jalla"]

//var truthArray: [String] = ["What is the main thing that attracts you to the opposite sex?"]

let challengeBundle = NSBundle.mainBundle()
let challengePath = challengeBundle.pathForResource("challenges", ofType: "txt")
var challengeString = String(contentsOfFile: challengePath!, encoding: NSUTF8StringEncoding, error: nil)!
var challengeArray = split(challengeString) {$0 == "\n"}

let truthBundle = NSBundle.mainBundle()
let truthPath = truthBundle.pathForResource("truth", ofType: "txt")
var truthString = String(contentsOfFile: truthPath!, encoding: NSUTF8StringEncoding, error: nil)!
var truthArray = split(truthString) {$0 == "\n"}

let min = 0
let max = challengeArray.count - 1
let randomNumberChallengeArray = shuffle(min...max)

let min2 = 0
let max2 = truthArray.count - 1
let randomNumberTruthArray = shuffle(min2...max2)


func shuffle<S: SequenceType>(source: S) -> [S.Generator.Element] {
    var rangen = GeneratorOf { arc4random() }
    let a = Array(Zip2(rangen, source))
    return a.sorted { $0.0 < $1.0 }.map { $0.1 }
}

