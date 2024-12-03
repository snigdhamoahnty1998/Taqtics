*** Settings ***
Library    SeleniumLibrary



*** Variables ***
${Valid_Username}        intern@taqtics.co      
${Valid_Password}        TestIntern@123
${Invalid_Username}        Intern1@123
${Invalid_Password}        12345
${EMPTY_user}            ${EMPTY}
${EMPTY_Password}        ${EMPTY}
${user_field}        xpath=//input[@id = "email"]
${Password_field}    xpath=//input[@id = "password"]     
${Login}            xpath=//button[@type='submit']




*** Test Cases ***
Login with valid Username

    Open Browser    https://landmark.taqtics.co    chrome
    Sleep    2s   
    Maximize Browser Window
    Sleep    5s
    Input Text    ${user_field}    ${Valid_Username}
    Wait Until Element Is Visible    ${user_field}    timeout=10s
    Input Text    ${Password_field}    ${Valid_Password} 
    Wait Until Element Is Visible    ${Password_field}    timeout=10s        
    Click Element    ${Login} 
    Sleep    5s
    Close Browser 
    Sleep    10s


Login with Invalid Username

    Open Browser    https://landmark.taqtics.co    chrome  
    Maximize Browser Window  
    Wait Until Element Is Visible    ${user_field}    timeout=10s
    Input Text    ${user_field}    ${Invalid_Username}
    Wait Until Element Is Visible    ${Password_field}    timeout=10s
    Input Text    ${Password_field}    ${Invalid_Password} 
    Wait Until Element Is Visible    ${Login}    timeout=10s
    Click Element    ${Login}
    Sleep    5s  
    Close Browser

Login with Empty Valid_Username

    Open Browser    https://landmark.taqtics.co    chrome 
    Maximize Browser Window
    Wait Until Element Is Visible    ${user_field}    timeout=10s 
    Input Text    ${user_field}        ${EMPTY}
    Wait Until Element Is Visible    ${Password_field}    timeout=10s
    Input Text    ${Password_field}    ${EMPTY}
    Wait Until Element Is Visible    ${Login}    timeout=10s
    Click Element    ${Login}
    Sleep    5s  
    Close Browser 






