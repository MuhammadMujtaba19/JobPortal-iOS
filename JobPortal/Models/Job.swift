//
//  Job.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/28/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import Foundation
class Job:Decodable{
    public var Title:String?
    public var JobID:Int?
    public var Organization:String?
    public var LastApplyDate:String?
    public var Designation:String?
    public var MinExperience:Int?
    public var Attachments:String?
    public var ApplicationLink:String?
    public var ContactPerson:String?
}
