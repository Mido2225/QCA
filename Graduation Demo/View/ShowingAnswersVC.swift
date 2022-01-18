//
//  ShowingAnswersVC.swift
//  Graduation Demo
//
//  Created by Mohamed Aglan on 6/23/21.
//

import UIKit

class ShowingAnswersVC: UIViewController {
    
    //MARK: - SetUp UI Elements
    
    var proDelegate:SendingProfessorDara?
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let secondView: UIView = {
        let second = UIView()
        second.backgroundColor = .white
        second.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        second.translatesAutoresizingMaskIntoConstraints = false
        return second
    }()
    
    
    
    let studentAnswer: UILabel = {
        let student = UILabel()
        student.textAlignment = .center
        student.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        student.text = "Student Answer"
        student.translatesAutoresizingMaskIntoConstraints = false
        return student
    }()
    
    let profissorAnswer: UILabel = {
        let profissor = UILabel()
        profissor.textAlignment = .center
        profissor.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        profissor.text = "Professor Answer"
        profissor.translatesAutoresizingMaskIntoConstraints = false
        return profissor
    }()
    
    let stuedentTextView: UITextView = {
        let ocr = UITextView()
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
    
    
    let proffisorTextView: UITextView = {
        let ocr = UITextView()
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

    
    lazy var compareButton: UIButton = {
        let send = UIButton()
        send.setTitle("Compare", for: .normal)
        send.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        send.setTitleColor(.white, for: .normal)
        send.layer.cornerRadius = 8
        send.backgroundColor = UIColor(red: 51/255, green: 61/255, blue: 190/255, alpha: 1)
        send.addTarget(self, action: #selector(sending), for: .touchUpInside)
        send.translatesAutoresizingMaskIntoConstraints = false
        return send
    }()
    @objc func sending() {
        
        sendingData()
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addingViews()
        addingLayOut()
        
    }
    
        
    //MARK: - Adding Views
    
    
    func addingViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(secondView)
        secondView.addSubview(studentAnswer)
        secondView.addSubview(stuedentTextView)
        secondView.addSubview(profissorAnswer)
        secondView.addSubview(proffisorTextView)
        secondView.addSubview(compareButton)
        
    }
    
    //MARK: - Adding Constraints
    
    func addingLayOut() {
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        secondView.anchor(top: scrollView.topAnchor, left: view.leftAnchor, bottom: scrollView.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 900)
        
        studentAnswer.anchor(top: secondView.safeAreaLayoutGuide.topAnchor, left: secondView.centerXAnchor, bottom: nil, right: nil, paddingTop: 100, paddingLeft: -50, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        stuedentTextView.anchor(top: studentAnswer.bottomAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: secondView.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 200)
        
        profissorAnswer.anchor(top: stuedentTextView.bottomAnchor, left: secondView.centerXAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: -50, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        proffisorTextView.anchor(top: profissorAnswer.bottomAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: secondView.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 200)
        
        compareButton.anchor(top: nil, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: secondView.safeAreaLayoutGuide.bottomAnchor, right: secondView.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 50, paddingRight: 25, width: 0, height: 48)
        
        
    }
    
    
    //MARK: - API Services
    
    func sendingData() {

        
        ApiService.getData(studentText: stuedentTextView.text ?? "" , professorText: proffisorTextView.text ?? "") { result in
            switch result{
            case.success (let data):
                    print(data)
                    let percentage = data.percent
                    
                    ApiService.getKeyWords(studentText: self.stuedentTextView.text ?? "") { result in

                           switch result{
                           case.success (let data):
                               print(data)
                               let keywords = data.keywords?.joined(separator:"-")
                            
                               DispatchQueue.main.async {
                                let sendFinalData = SimilarityVC()
                                sendFinalData.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                                sendFinalData.setData(keyWordsList: keywords ?? "", similarityPercentage: percentage ?? "")
                                self.present(sendFinalData, animated: true, completion: nil)
                            }
                            
                           case.failure(let error):
                               print("failed")
                               print(error)
                           }
                       }
                
            case.failure(let error):
                print("failed")
                print(error)
            }
        }
        
        
        
        }
        
        
    }
    
