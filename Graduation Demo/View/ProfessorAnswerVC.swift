//
//  ProfessorAnswerVC.swift
//  Graduation Demo
//
//  Created by Mohamed Aglan on 6/23/21.
//

import UIKit
import Vision

protocol SendingProfessorDara {
    func professorData(proData: String)
}

class ProfessorAnswerVC: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate,SendingProfessorDara {
    func professorData(proData: String) {
    }
    

    var delegate:SendingStudentData?
    
    //MARK: - SetUp UI Elements
    
    let holdingData: UILabel = {
        let hold = UILabel()
        hold.text = ""
        return hold
    }()
    
    let scrollView: UIScrollView = {
            let v = UIScrollView()
        v.backgroundColor = .white
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
    
    
    let headerTitle: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.textColor = .black
        title.text = "Typical answer"
        title.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let uploadButton: UIButton = {
        let upload = UIButton()
        upload.backgroundColor = .clear
        upload.setTitle("Upload File", for: .normal)
        upload.setImage(UIImage(named: "upArrow"), for: .normal)
        upload.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        upload.setTitleColor(UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1), for: .normal)
        upload.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        upload.addTarget(self, action: #selector(OpenGalarry), for: .touchUpInside)
        upload.translatesAutoresizingMaskIntoConstraints = false
        return upload
    }()
    @objc func OpenGalarry() {
        setupGallary()
    }
    
    let captureImage: UIButton = {
        let capture = UIButton()
        capture.backgroundColor = .clear
        capture.setTitle("Capture Image", for: .normal)
        capture.setImage(UIImage(named: "Camera"), for: .normal)
        capture.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        capture.setTitleColor(UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1), for: .normal)
        capture.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        capture.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        capture.addTarget(self, action: #selector(OpenCamera), for: .touchUpInside)
        capture.translatesAutoresizingMaskIntoConstraints = false
        return capture
    }()
    @objc func OpenCamera() {
        setUpCamera()
    }
    
    let orLbl: UILabel = {
        let or = UILabel()
        or.text = "OR"
        or.textAlignment = .center
        or.textColor = UIColor(red: 6/255, green: 21/255, blue: 175/255, alpha: 1)
        or.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        or.translatesAutoresizingMaskIntoConstraints = false
        return or
    }()
    
    var middleImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "answerBackGround12")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let textViewLbl: UILabel = {
        let textLbl = UILabel()
        textLbl.text = "Professor Answer"
        textLbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textLbl.textAlignment = .left
        textLbl.translatesAutoresizingMaskIntoConstraints = false
        return textLbl
    }()
    
    let ocrTextView: UITextView = {
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
    
    
    let descriptionLbl: UILabel = {
        let des = UILabel()
        des.text = "Press send to check all answers."
        des.textAlignment = .left
        des.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        des.translatesAutoresizingMaskIntoConstraints = false
        return des
    }()
    
    lazy var sendButton: UIButton = {
        let send = UIButton()
        send.setTitle("Next", for: .normal)
        send.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        send.setTitleColor(.white, for: .normal)
        send.layer.cornerRadius = 8
        send.backgroundColor = UIColor(red: 51/255, green: 61/255, blue: 190/255, alpha: 1)
        send.addTarget(self, action: #selector(showingPress), for: .touchUpInside)
        send.translatesAutoresizingMaskIntoConstraints = false
        return send
    }()
    
    @objc func showingPress() {
        let showVC = ShowingAnswersVC()
        showVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        showVC.proDelegate = self
        showVC.stuedentTextView.text = holdingData.text
        showVC.proffisorTextView.text = ocrTextView.text
        present(showVC, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingViews()
        addingConstraint()
    }
    
    //MARK: - Adding Views
    
    func addingViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(secondView)
        secondView.addSubview(headerTitle)
        secondView.addSubview(uploadButton)
        secondView.addSubview(captureImage)
        secondView.addSubview(orLbl)
        secondView.addSubview(middleImg)
        secondView.addSubview(textViewLbl)
        secondView.addSubview(ocrTextView)
        secondView.addSubview(descriptionLbl)
        secondView.addSubview(sendButton)
    }
    
    //MARK: - Adding Constraints
    
    func addingConstraint() {

        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        secondView.anchor(top: scrollView.topAnchor, left: view.leftAnchor, bottom: scrollView.bottomAnchor, right: view.rightAnchor, paddingTop: -50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1200)
    
        
        headerTitle.anchor(top: secondView.safeAreaLayoutGuide.topAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: secondView.safeAreaLayoutGuide.rightAnchor, paddingTop: 45, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 0)
        
        uploadButton.anchor(top: headerTitle.bottomAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 100, height: 0)
        
        captureImage.anchor(top: headerTitle.bottomAnchor, left: nil, bottom: nil, right: secondView.safeAreaLayoutGuide.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 130, height: 0)
        
        orLbl.anchor(top: headerTitle.bottomAnchor, left: uploadButton.rightAnchor, bottom: nil, right: captureImage.leftAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        middleImg.anchor(top: orLbl.bottomAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: secondView.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 300)
    
        textViewLbl.anchor(top: middleImg.bottomAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        ocrTextView.anchor(top: textViewLbl.bottomAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: secondView.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 150)
        
        descriptionLbl.anchor(top: ocrTextView.bottomAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        sendButton.anchor(top: descriptionLbl.bottomAnchor, left: secondView.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: secondView.safeAreaLayoutGuide.rightAnchor, paddingTop: 15, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 48)
        
    }
    
    //MARK: - Opening Gallary
    
    func setupGallary() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let imagePhotoLibrary = UIImagePickerController()
            imagePhotoLibrary.delegate = self
            imagePhotoLibrary.allowsEditing = true
            imagePhotoLibrary.sourceType = .photoLibrary
            self.present(imagePhotoLibrary, animated: true, completion: nil)
        }
    }
    
    //MARK: - Opening Camera
    
    func setUpCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let imagePhotoLibrary = UIImagePickerController()
            imagePhotoLibrary.delegate = self
            imagePhotoLibrary.allowsEditing = true
            imagePhotoLibrary.sourceType = .camera
            self.present(imagePhotoLibrary, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage]as? UIImage
        self.middleImg.image = image
        recognizeText(image: middleImg.image)
    }
    
    
    
    //MARK: - OCR Recognition
    
    
    func recognizeText(image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
         
        // handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // request
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observation = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            let text = observation.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ", ")
            
            DispatchQueue.main.async {
                self?.ocrTextView.text = text
            }
        }
        
        // process request
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
        
    }
    

}
