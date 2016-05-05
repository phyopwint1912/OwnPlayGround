//
//  FaceView.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 3/5/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var color: UIColor = UIColor.brownColor() { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var lineWeight: CGFloat = 4.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var eyesOpen: Bool = true { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var eyeBrowTilt: Double = -0.5 { didSet { setNeedsDisplay() } }

    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    private struct Rations {
        static let SkullRadiusOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 5
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenterPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: midPoint, radius: radius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        path.lineWidth = lineWeight
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Rations.SkullRadiusOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left:
            eyeCenter.x -= eyeOffset
        case .Right:
            eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    func changeScale(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .Changed, .Ended:
            scale *= recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath {
        let eyeRadius = skullRadius / Rations.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        if eyesOpen {
            return pathForCircleCenterPoint(eyeCenter, withRadius: eyeRadius)
        } else {
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLineToPoint(CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = 5.0
            return path
        }
        
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Rations.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Rations.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Rations.SkullRadiusOffset
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWeight
        return path
    }
    
    private func pathForBrow(eye: Eye) -> UIBezierPath {
        var tilt = eyeBrowTilt
        switch eye {
        case .Left: tilt *= -1.0
        case .Right: break
        
        }
        var browCenter = getEyeCenter(eye)
        browCenter.y -= skullRadius / Rations.SkullRadiusToBrowOffset
        
        let eyeRadius = skullRadius / Rations.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1,min(tilt, 1))) * eyeRadius / 2
        
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.moveToPoint(browStart)
        path.addLineToPoint(browEnd)
        path.lineWidth = lineWeight
        return path
    }
    
    override func drawRect(rect: CGRect) {
        color.set()
        pathForCircleCenterPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
        pathForBrow(.Left).stroke()
        pathForBrow(.Right).stroke()
    }


}
