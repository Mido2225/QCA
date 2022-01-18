//
//  Constants.swift
//  Home Care
//
//  Created by Mohamed Aglan on 6/3/21.
//

import Foundation
struct Constants {

    struct ProductionServer {
//        https://text-sim-api.herokuapp.com
        // https://keyword-ext.herokuapp.com/api/keywords
        static let baseURL = ""
    }
    struct APIParameterKey {
//        static let locale = "language"
//        static let statusId = "STATUS_ID"
//        static let date = "VISIT_DATE"
//        static let details = "DETAIL"
//        static let docId = "DOCTOR_ID"
//        static let recId = "REC_ID"
//        static let Name = "DISPLAY_NAME"
//        static let medFileNum = "MED_FILE_NO"
//        static let familyMedFileNum = "FAMILY_MED_FILE_NO"
//        static let familyIdNum = "FAMILY_ID_NO"
//        static let mobileNum = "MOBILE_NO"
//        static let id = "ID_NO"
//        static let medNum = "MED_FILE_NO"
//        static let mobile = "MOBILE_NO"
//        static let username = "username"
//        static let password = "password"
//        static let lang = "LANGUAGE"
//        static let SURVEYID = "SURVEY_ID"
//        static let VISITDATE = "VISIT_DATE"
//        static let DOCTORID = "DOCTOR_ID"
//        static let COMMENT = "COMMENT"
//        static let SUBMITTEDBY = "SUBMITTED_BY"
//        static let DETAIL = "DETAIL"
//        static let TYPE_ID = "TYPE_ID"
//        static let CATEGORY_ID = "CATEGORY_ID"
//        static let SUBCATEGORY_ID = "SUBCATEGORY_ID"
//        static let NAME = "NAME"
//        static let INVOLVED_PERSON_ID = "INVOLVED_PERSON_ID"
//        static let CREATED_BY = "CREATED_BY"
    }
    enum RequestMethods: String {
        case delete = "DELETE"
        case put = "PUT"

    }
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case locale = "X-locale"
        case ApiVer = "Api-Version"
    }

    enum ContentType: String {
        case json = "application/json"
        case token = "fmctoken"
        case  form = "application/x-www-form-urlencoded"
        case ApiVer = "v1"
    }
}
