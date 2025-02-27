// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/regex;
import ballerina/test;

const string KEYSTORE_PATH = "tests/resources/keystore/ballerinaKeystore.p12";
const string TRUSTSTORE_PATH = "tests/resources/keystore/ballerinaTruststore.p12";
const string PRIVATE_KEY_PATH = "tests/resources/key/private.key";
const string ENCRYPTED_PRIVATE_KEY_PATH = "tests/resources/key/encryptedPrivate.key";
const string PUBLIC_CERT_PATH = "tests/resources/cert/public.crt";
const string WSO2_PUBLIC_CERT_PATH = "tests/resources/cert/wso2Public.crt";

isolated function assertToken(string token) {
    string[] parts = regex:split(token, "-");
    test:assertEquals(parts.length(), 5);
    test:assertEquals(parts[0].length(), 8);
    test:assertEquals(parts[1].length(), 4);
    test:assertEquals(parts[2].length(), 4);
    test:assertEquals(parts[3].length(), 4);
    test:assertEquals(parts[4].length(), 12);
}

// Build the complete error message by evaluating all the inner causes and asserting the inclusion.
isolated function assertContains(error err, string text) {
    string message = err.message();
    error? cause = err.cause();
    while cause is error {
        message += " " + cause.message();
        cause = cause.cause();
    }
    test:assertTrue(message.includes(text));
}
