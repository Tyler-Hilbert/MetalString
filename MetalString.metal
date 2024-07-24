// Experimental String class functions on GPU using Metal

#include <metal_stdlib>

#define MAX_STRING_SIZE 100
#define MAX_STRING_DISK_SIZE (MAX_STRING_SIZE + 1) // For null terminator

using namespace metal;


int stoi(const char str[MAX_STRING_DISK_SIZE]);
long stol(const char str[MAX_STRING_DISK_SIZE]);
unsigned int stoul(const char str[MAX_STRING_DISK_SIZE]);
float stof(const char str[MAX_STRING_DISK_SIZE]);

size_t length(const char str[MAX_STRING_DISK_SIZE]);
size_t size(const char str[MAX_STRING_DISK_SIZE]);
size_t max_size(const char str[MAX_STRING_DISK_SIZE]);
//// To implement       void resize (size_t n);void resize (size_t n, char c);
//// To implement       size_t capacity();
//// To implement       void reserve (size_t n = 0);
void clear(char str[MAX_STRING_DISK_SIZE]);
bool empty(const char str[MAX_STRING_DISK_SIZE]);
//// To implement       void shrink_to_fit();

//// To implement        char& operator[] (size_t pos);const char& operator[] (size_t pos) const;
// Note these return constants rather than C++ which returns references
char at(char str[MAX_STRING_DISK_SIZE], size_t pos);
char back(const char str[MAX_STRING_DISK_SIZE]);
char front(const char str[MAX_STRING_DISK_SIZE]);



// Convert string to int
int stoi(const char str[MAX_STRING_DISK_SIZE]) {
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
long stol(const char str[MAX_STRING_DISK_SIZE]) {
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
unsigned int stoul(const char str[MAX_STRING_DISK_SIZE]) {
    unsigned int res = 0;
    int i = 0;

    for (; str[i] != '\0'; ++i)
        res = res * 10 + str[i] - '0';

    return res;
}



// Convert string to float
float stof(const char str[MAX_STRING_DISK_SIZE]) {
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



// Function to calculate the length of the string
size_t length(const char str[MAX_STRING_DISK_SIZE]) {
    size_t len = 0;
    while (str[len] != '\0') {
        len++;
    }
    return len;
}



// Function to calculate the size of the string, using the length() function
size_t size(const char str[MAX_STRING_DISK_SIZE]) {
    return length(str);
}



// Function to return the maximum size of the string
size_t max_size(const char str[MAX_STRING_DISK_SIZE]) {
    return MAX_STRING_SIZE;
}



// Function to clear the contents of the string
void clear(char str[MAX_STRING_SIZE]) {
    for (size_t i = 0; i < MAX_STRING_SIZE; ++i) {
        str[i] = '\0';
    }
}



// Function to check if the string is empty
bool empty(const char str[MAX_STRING_SIZE]) {
    return str[0] == '\0';
}



// Returns character at position pos
// Note C++ returns reference usually
char at(const char str[MAX_STRING_SIZE], size_t pos) {
    assert(pos < MAX_STRING_SIZE);
    return str[pos];
}



// Returns last character
// Note C++ returns reference usually
char back(const char str[MAX_STRING_DISK_SIZE]) {
    // Iterate to find the last character before the null terminator
    size_t i = 0;
    while (i < MAX_STRING_SIZE && str[i] != '\0') {
        i++;
    }

    assert(i > 0); // Ensure the string is not empty
    return str[i - 1];
}



// Returns first character
// Note C++ returns reference usually
char front(const char str[MAX_STRING_DISK_SIZE]) {
    assert(!empty(str)); // Ensure the string is not empty
    return str[0];
}
