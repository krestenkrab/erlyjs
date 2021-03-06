// Mandatory. Provide here a description of the test case.
function test_description() {
    return "Prediefined core object 'Math', mehod: 'atan2'";
}

// Mandatory. Provide here the arguments the testsuite will use 
// to invoke the test() function.
function test_args() {
    return [];
}

// Mandatory. Provide here the expected test result. 
function test_ok() {
    return 0.24497866312686414;
}

// Optional. Provide here any global code.


// Mandatory. The actual test. 
// Testsuite invokes this function with the arguments from test_args()
// and compares the return value with the expected result from test_result().
function test() {
    return Math.atan2(0.5, 2.0); 
}