//
//  Delay_Method.swift
//  4K HD Wallpapers
//
//  Created by Sufyan Akhtar on 06/12/2022.
//

import Foundation

func delay(durationInSeconds seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}
