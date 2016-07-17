//
//  PCTextHelper.cpp
//  ProjectCleaner
//
//  Created by qinzhiwei on 16/7/17.
//  Copyright © 2016年 lobster. All rights reserved.
//

#include "PCTextHelper.hpp"
#include <string>
#include <fstream>
#include <iostream>
#include <string.h>

using namespace std;

int isTextInFile(const char *filePath,const char *text){
    
    ifstream file(filePath);
    string lineString;
    int isTextIn;
    while (getline(file, lineString)) {
        if(lineString.find(text) != string::npos){
            isTextIn = 1;
            break;
        }
    }
    return isTextIn;
}