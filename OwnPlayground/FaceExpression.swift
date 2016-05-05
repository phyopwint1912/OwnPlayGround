//
//  FaceExpression.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 5/5/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import Foundation

struct FaceExpression {
    
    enum Eyes: Int {
        case Open
        case Closed
        case Squinting
    }
    
    enum EyeBrows: Int {
        case Relaxed
        case Normal
        case Furrowed
        func moreRealxedBrow() -> EyeBrows {
            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        func moreFurrowedBrow() -> EyeBrows {
            return EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
        }
    }
    
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        func saddedMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var eyes: Eyes
    var eyeBrows: EyeBrows
    var mouth: Mouth

 }
