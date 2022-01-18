//
//  SimilarityVC.swift
//  Graduation Demo
//
//  Created by Mohamed Aglan on 6/23/21.
//

import UIKit

class SimilarityVC: UIViewController {
    
    
    
    var keyWordsList = ""
    var similarityPercentage:String = ""
    
    
    func setData(keyWordsList:String , similarityPercentage:String)  {
        self.keyWordsList = keyWordsList
        self.similarityPercentage = similarityPercentage
    }
    
    let keyWords: UILabel = {
        let ocr = UILabel()
        ocr.numberOfLines = 0
        ocr.layer.borderWidth = 1
        ocr.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        ocr.layer.shadowColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        ocr.layer.shadowRadius = 10
        ocr.layer.shadowOpacity = 0.7
        ocr.layer.cornerRadius = 8
        ocr.clipsToBounds = true
        ocr.translatesAutoresizingMaskIntoConstraints = false
        return ocr
    }()

    let middleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = " 0 % "
        lbl.textColor = .blue
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        return lbl
    }()

    lazy var checkAnotherBtn: UIButton = {
        let check = UIButton()
        check.backgroundColor =  UIColor(red: 51/255, green: 61/255, blue: 190/255, alpha: 1)
        check.layer.cornerRadius = 4
        check.setTitle("Check another answer", for: .normal)
        check.setTitleColor(.white, for: .normal)
        check.addTarget(self, action: #selector(returnButton), for: .touchUpInside)
        return check
    }()

    @objc func returnButton() {
        let firstVC = StudentAnswerVC()
        firstVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(firstVC, animated: true, completion: nil)
    }
    
    lazy var checkNewOneBt: UIButton = {
        let checkTwo = UIButton()
        checkTwo.backgroundColor =  UIColor(red: 51/255, green: 61/255, blue: 190/255, alpha: 1)
        checkTwo.layer.cornerRadius = 4
        checkTwo.setTitle("Check a new student answer", for: .normal)
        checkTwo.setTitleColor(.white, for: .normal)
        checkTwo.addTarget(self, action: #selector(returnButton), for: .touchUpInside)
        return checkTwo
    }()

    let keyWordsLbl: UILabel = {
        let keys = UILabel()
        keys.textAlignment = .center
        keys.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        keys.text = "Key Words"
        keys.translatesAutoresizingMaskIntoConstraints = false
        return keys
    }()
    

    let shaperLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(keyWords)
        view.addSubview(checkNewOneBt)
        view.addSubview(keyWordsLbl)
        view.addSubview(checkAnotherBtn)
        view.addSubview(middleLbl)

        keyWords.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 500, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 170)
        
        
        keyWordsLbl.anchor(top: nil, left: keyWords.safeAreaLayoutGuide.leftAnchor, bottom: keyWords.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)

        checkNewOneBt.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: checkAnotherBtn.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 20, paddingRight: 40, width: 0, height: 44)
        checkAnotherBtn.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 20, paddingRight: 40, width: 0, height: 44)

        middleLbl.frame = CGRect(x: 163, y: 150, width: 100, height: 100)

        let center = CGPoint(x: 210, y: 200)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        

        let trackShape = CAShapeLayer()
        trackShape.path = circularPath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 15
        trackShape.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackShape)


//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTab)))


    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        keyWords.text = self.keyWordsList
        handleTab()
        
    }

    var counting:Float = 0.0
    var timer = Timer()

    @objc func handleTab() {
        let center = CGPoint(x: 210, y: 200)
        let circularPathValue = UIBezierPath(arcCenter: center, radius: 100, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat( ((360/100.0)*(Double(similarityPercentage) ?? 0.0) )).toRadians(), clockwise: true)
        
        
        
        shaperLayer.path = circularPathValue.cgPath
        shaperLayer.strokeColor = UIColor.blue.cgColor
        shaperLayer.fillColor = UIColor.clear.cgColor
        shaperLayer.lineWidth = 10
        shaperLayer.lineCap = .round
        shaperLayer.strokeEnd = 0

        view.layer.addSublayer(shaperLayer)
        
        timer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(Action), userInfo: nil, repeats: true)

        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = Float(similarityPercentage)
        basicAnimation.duration = (timer.timeInterval) + 3
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shaperLayer.add(basicAnimation, forKey: "urSoBasic")



    }

    @objc func Action() {
        
        middleLbl.text = "\(counting) %"
        if counting >= Float(self.similarityPercentage) ?? 0.0 {
            timer.invalidate()
        }
        counting += 1
    }
    


}


extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
