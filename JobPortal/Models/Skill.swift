//
//  Skill.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/21/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import Foundation

class Skill:Decodable
{
    public var RefID:Int?
    public var StudentID:Int?
    public var SkillName:String?
    public var DomainName:String?
    
    init(RefID:Int,StudentID:Int,SkillName:String,DomainName:String) {
        self.RefID = RefID
        self.StudentID = StudentID
        self.SkillName = SkillName
        self.DomainName = DomainName
    }
}
