*** Settings ***
Documentation   This test suite is to verify the reimport feature in Import Wizard tool
Library   SeleniumLibrary 

Test Setup   Launch browser and login to web application
Test Teardown   Logout from the web application

*** Keywords ***

Launch browser and login to web application
    [Documentation]    To launch and login to web application
    Open Browser   ${application_url}   ${browser}
    Wait for page to load   ${login_button} 
    Input Text   ${username_field}   ${username_with_import_access}
    Input Text   ${password_field}   ${password}
    Click Button   ${submit_button}
    Wait for page to load   ${home_page}   


Logout from the web application
    [Documentation]     Logout from the application
    Click Button    ${logout_button}

Wait for page to load
    [Documentation]     A method to explicitly wait for an element
    [Arguments]    ${element}
    Wait Until Page Contains Element   ${element}

*** Variables ***
${application_url}    application url
${browser}    chrome
${login_button}   login_button_element
${username_field}   username_element
${password_field}   password_element
${username_with_import_access}    username
${password}    password
${submit_button}   submit_button_element
${home_page}    home_page_element
${logout_button}    logout_button_element
${file_locator}    file_locator_element    #This file locator is identified using file name
${file_name_text}    file_name_text
${file_outdated_icon}    outdated_file_icon   #This file locator is written first to identify the file and then identify the icon for file

*** Test Cases ***
Verify user can see icon for files that needs reimport
    [Documentation]    To check files which are outdated have icon to notify users
    Element Text Should Be    ${file_locator}    ${file_name_text}   #To check if file is present
    Page Should Contain Element   ${file_outdated_icon}   #To check if icon is present for a file
    

