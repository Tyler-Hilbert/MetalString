// Experimental String class functions on GPU using Metal

#include <metal_stdlib>


using namespace metal;


int stoi(const char str[100]);
long stol(const char str[100]);
unsigned int stoul(const char str[100]);
float stof(const char str[100]);



// Convert string to int
int stoi(const char str[100]) {
    int res = 0; // Initialize result
    int sign = 1; // Initialize sign as positive
    int i = 0; // Initialize index of first digit

    // If number is negative, then update sign
    if (str[0] == '-') {
        sign = -1;
        i++; // Also update index of first digit
    }

    // Iterate through all digits and update the result
    for (; str[i] != '\0'; ++i)
        res = res * 10 + str[i] - '0';

    // Return result with sign
    return sign * res;
}



// Convert string to long int
long stol(const char str[100]) {
    long res = 0;
    int sign = 1;
    int i = 0;

    // If number is negative, then update sign
    if (str[0] == '-') {
        sign = -1;
        i++;
    }

    // Iterate through all digits and update the result
    for (; str[i] != '\0'; ++i)
        res = res * 10 + str[i] - '0';

    // Return result with sign
    return sign * res;
}



// Convert string to unsigned int
unsigned int stoul(const char str[100]) {
    unsigned int res = 0;
    int i = 0;

    for (; str[i] != '\0'; ++i)
        res = res * 10 + str[i] - '0';

    return res;
}



// Convert string to float
float stof(const char str[100]) {
    float res = 0.0; // Initialize result
    float factor = 1.0;
    int sign = 1; // Initialize sign as positive
    int i = 0; // Initialize index of first digit

    // If number is negative, then update sign
    if (str[0] == '-') {
        sign = -1;
        i++; // Also update index of first digit
    }

    // Iterate through all digits before the decimal point and update the result
    for (; str[i] != '\0' && str[i] != '.'; ++i)
        res = res * 10.0 + str[i] - '0';

    // If there is a decimal point, iterate through all digits after the decimal point
    if (str[i] == '.') {
        i++;
        for (; str[i] != '\0'; ++i) {
            factor *= 0.1;
            res = res + (str[i] - '0') * factor;
        }
    }

    // Return result with sign
    return sign * res;
}
