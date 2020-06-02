//
//  JobDetails.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/30/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import Foundation
class JobDetails:Decodable{
    public var Title:String?
    public var JobID:Int?
    public var Organization:String?
    public var LastApplyDate:String?
    public var Designation:String?
    public var MinExperience:Int?
    public var AttachmentPath:String?
    public var ApplicationLink:String?
    public var Contactperson:String?
    public var DescID:Int?
    public var Description:String?
    public var DescriptionList:[String]?
    //public string JobTagID { get; set; }
}
