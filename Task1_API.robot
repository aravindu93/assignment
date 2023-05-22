*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  JSONLibrary
Library  OperatingSystem

*** Variables ***

${token}   #Used to store token
${url}  #Used to store url
${bearer_token}   #This will be used to store token for authentication if it use bearer token
${File_Path}   #File path


*** Keywords ***
Open Connection to File Upload Wizard API
    ${headers}=    Create Dictionary   Autorization=${bearer_token}   #Create header disctionary and add necessary parameters like authentication
    Create Session   uploadFile   ${url}   ${headers}   #Create a session

*** Test Cases ***
Get status code and message when using unsupported file in upload wizard
    [Documentation]    Verify error code and error message when user tries to upload non-supported file
    Open Connection to File Upload Wizard API
    ${expected_status_code}=   Set Variable   4xx    #Store the expected status code to a variable
    ${expected_text}=   Set Variable   "An error message"  #Store the expected error message to a variable
    ${file_name}=  Get File For Streaming Upload  ${File_Path}   #Get the .txt file
    ${asset}=  Create Dictionary   asset={file_name}  #To store the file to be send in request
    ${headers}=   Create Dictionary   #Add necessary headers for the request
    ${response}=   POST On Session   uploadFileSession  ${url}  ${asset}   ${headers}   expected_status=any   
    Should Be Equal As Strings   ${response.status_code}   ${expected_status_code}   #Checking the response status is same as expected   
    ${json} =  Set Variable  ${response.json()}
    ${json_string}    Convert JSON To String    ${json}
    Should Be Equal As Strings   ${json_string}   ${expected_text}  #Checking the response error message is same as expected   
    


