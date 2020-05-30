//
//  Project.swift
//  JobPortal
//
//  Created by Muhammad Mujtaba on 5/21/20.
//  Copyright © 2020 Muhammad Mujtaba. All rights reserved.
//

import Foundation

class Project:Decodable{
    
    public var StudentID:Int?
    public var ProjectID:Int?
    public var ProjectName:String?
    public var GithubLink:String?
    
    public var courseOfferedID:Int?
    public var ApproveStatus:String?
    public var Fname :String?
    public var FrameworkID:Int?

    public var DomainID:Int?
    public var DomainName:String?
    public var Skillvalue:String?
    
//    init(StudentID:Int,ProjectID:Int,ProjectName:String,GithubLink:String,courseOfferedID:Int,ApproveStatus:String,Fname:String,FrameworkID:Int,DomainID:Int,DomainName:String,Skillname:String) {
//        self.StudentID = StudentID
//        self.ProjectID = ProjectID
//        self.ProjectName = ProjectName
//        self.GithubLink = GithubLink
//        self.courseOfferedID = courseOfferedID
//        self.ApproveStatus = ApproveStatus
//        self.Fname = Fname
//        self.FrameworkID = FrameworkID
//        self.DomainID  =  DomainID
//        self.DomainName  =  DomainName
//        self.Skillvalue = Skillname
//    }
}
