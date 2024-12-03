*** Settings ***
Library    RequestsLibrary
Library    Collections  # For handling dictionaries and JSON

*** Variables ***
${BASE_URL}       https://landmark.taqtics.co/v1/external
${API_ENDPOINT}   /generateAuthToken
${VALID_USER}     admin@taqtics.co
${VALID_PASS}     TestAdmin@123
${NON_ADMIN_USER}  intern@taqtics.co
${NON_ADMIN_PASS}  TestIntern@123
${VALID_ADMIN_CREDENTIALS}    {"username": "admin@taqtics.co", "password": "TestAdmin@123"}

*** Test Cases ***

# Positive Case: Valid Admin Login
Valid Admin Login Should Generate Token
    [Documentation]    Verify token is generated with valid admin credentials.
    Create Session     auth_session    ${BASE_URL}   # Define session with base URL
         ${response}=      POST    auth_session${API_ENDPOINT}    json=${VALID_ADMIN_CREDENTIALS}  # Use session and endpoint
    Should Be Equal As Numbers    ${response.status_code}    200
    ${token}=          Get From Dictionary    ${response.json()}    token
    Should Not Be Empty    ${token}

# Negative Case: Non-Admin Login
Non-Admin Login Should Return Forbidden Error
    [Documentation]    Verify non-admin credentials return 403 Forbidden error.     
    Create Session     auth_session    ${BASE_URL}
    ${response}=       POST    auth_session${API_ENDPOINT}    json={"username": "${NON_ADMIN_USER}", "password": "${NON_ADMIN_PASS}"}
    Should Be Equal As Numbers    ${response.status_code}    403
    ${error}=          Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    "Access Denied"

# Edge Case: Blank Credentials
Blank Credentials Should Return Error
    [Documentation]    Verify blank credentials return 400 Bad Request error.
    Create Session     auth_session    ${BASE_URL}
    ${response}=       POST    auth_session${API_ENDPOINT}    json={"username": "", "password": ""}
    Should Be Equal As Numbers    ${response.status_code}    400
    ${error}=          Get From Dictionary    ${response.json()}    error
    Should Contain    ${error}    "Invalid input"
