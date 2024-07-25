// Experimental String class functions (uses C++ definitinos) on GPU using Metal
// https://cplusplus.com/reference/string/string/

#include <metal_stdlib>

#define MAX_STRING_SIZE 100
#define MAX_STRING_DISK_SIZE (MAX_STRING_SIZE + 1) // For null terminator

constant size_t NPOS = -1;

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

//// To implement       string& operator+= (const string& str); string& operator+= (const char* s); string& operator+= (char c); string& operator+= (initializer_list<char> il);
void append(char dest[MAX_STRING_DISK_SIZE], const char src[MAX_STRING_DISK_SIZE]);
void push_back(char str[MAX_STRING_DISK_SIZE], char c);
void assign(char dest[MAX_STRING_DISK_SIZE], const char src[MAX_STRING_DISK_SIZE]);
void assign(char dest[MAX_STRING_DISK_SIZE], const char src[MAX_STRING_DISK_SIZE], size_t subpos, size_t sublen);
void assign(char dest[MAX_STRING_DISK_SIZE], const char src[MAX_STRING_DISK_SIZE], size_t sublen);
void assign(char str[MAX_STRING_DISK_SIZE], size_t n, char c);
void insert(char dest[MAX_STRING_DISK_SIZE], size_t pos, const char src[MAX_STRING_DISK_SIZE]);
void insert(char dest[MAX_STRING_DISK_SIZE], size_t pos, const char src[MAX_STRING_DISK_SIZE], size_t subpos, size_t sublen);
void insert(char dest[MAX_STRING_DISK_SIZE], size_t pos, const char src[MAX_STRING_DISK_SIZE], size_t sublen);
void insert(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t n, const char src[MAX_STRING_DISK_SIZE], size_t sublen);
void erase(char str[MAX_STRING_DISK_SIZE], size_t pos, size_t len);
void replace(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t len, const char src[MAX_STRING_DISK_SIZE]);
void replace(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t len, const char src[MAX_STRING_DISK_SIZE], size_t subpos, size_t sublen);
void replace(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t len, const char src[MAX_STRING_DISK_SIZE], size_t sublen);
void replace(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t len, char c);
void swap(char swap1[MAX_STRING_DISK_SIZE], char swap2[MAX_STRING_DISK_SIZE]);
void pop_back(char str[MAX_STRING_DISK_SIZE]);



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// Function to calculate the length of the string
// Note does not include NULL terminator
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



// Function to return the maximum size of the string not including null terminator
size_t max_size(const char str[MAX_STRING_DISK_SIZE]) {
    return MAX_STRING_SIZE;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// Function to clear the contents of the string
void clear(char str[MAX_STRING_DISK_SIZE]) {
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        str[i] = '\0';
    }
}



// Function to check if the string is empty
bool empty(const char str[MAX_STRING_DISK_SIZE]) {
    return str[0] == '\0';
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// Returns character at position pos
// Note C++ returns reference usually
char at(const char str[MAX_STRING_DISK_SIZE], size_t pos) {
    assert(pos < MAX_STRING_DISK_SIZE);
    return str[pos];
}



// Returns last character
// Note C++ returns reference usually
char back(const char str[MAX_STRING_DISK_SIZE]) {
    // Iterate to find the last character before the null terminator
    size_t i = 0;
    while (i < MAX_STRING_DISK_SIZE && str[i] != '\0') {
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



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Note C++ has different: string& append (const string& str); string& append (const string& str, size_t subpos, size_t sublen = npos); string& append (const char* s); string& append (const char* s, size_t n); string& append (size_t n, char c); template <class InputIterator>   string& append (InputIterator first, InputIterator last); string& append (initializer_list<char> il);
// Function to append one string to another
void append(char dest[MAX_STRING_DISK_SIZE], const char src[MAX_STRING_DISK_SIZE]) {
    size_t dest_length = length(dest);
    size_t src_length = length(src);
    assert(dest_length + src_length < MAX_STRING_DISK_SIZE); // Ensure enough space

    for (size_t i = 0; i < src_length; ++i) {
        dest[dest_length + i] = dest[i];
    }
    dest[dest_length + src_length] = '\0';
}



// Function to append a character to the end of the string
void push_back(char str[MAX_STRING_DISK_SIZE], char c) {
    size_t len = length(str);
    assert(len < MAX_STRING_SIZE); // Ensure there is space to add another character
    str[len] = c;
    str[len + 1] = '\0'; // Add null terminator
}



// Assign the contents of one char array to another
void assign(char dest[MAX_STRING_DISK_SIZE], const char src[MAX_STRING_DISK_SIZE]) {
    // Copy the source string to the destination
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        dest[i] = src[i];
    }
}



// Copies the portion of src that begins at the character position subpos and spans sublen characters (or until the end of src, if either src is too short or if sublen is npos).
void assign(char dest[MAX_STRING_DISK_SIZE], const char src[MAX_STRING_DISK_SIZE], size_t subpos, size_t sublen) {
    size_t src_length = length(src);
    assert(subpos <= src_length); // Ensure subpos is within the source string

    if (sublen == NPOS || subpos + sublen > src_length) { // TODO -- verify npos is correct
        sublen = src_length - subpos; // Adjust sublen if it exceeds the source string length
    }

    assert(subpos + sublen < MAX_STRING_DISK_SIZE); // Ensure the substring fits in the destination

    // Clear the destination string
    clear(dest);

    // Copy the substring from the source string to the destination
    for (size_t i = 0; i < sublen; ++i) {
        dest[i] = src[subpos + i];
    }
    dest[sublen] = '\0';
}



// Assign the first n characters from src to dest
void assign(char dest[MAX_STRING_DISK_SIZE], const char src[MAX_STRING_DISK_SIZE], size_t sublen) {
    assign(dest, src, 0, sublen);
}



// Fill str with n consecutive copies of character c.
void assign(char str[MAX_STRING_DISK_SIZE], size_t n, char c) {
    assert(n < MAX_STRING_DISK_SIZE); // Ensure n does not exceed the maximum size

    // Clear the destination string
    clear(str);

    // Fill the string with n copies of character c
    for (size_t i = 0; i < n; ++i) {
        str[i] = c;
    }
    str[n] = '\0'; // Add null terminator
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// Note C++ has different:string& insert (size_t pos, const string& str); string& insert (size_t pos, const string& str, size_t subpos, size_t sublen = npos); string& insert (size_t pos, const char* s); string& insert (size_t pos, const char* s, size_t n); string& insert (size_t pos,   size_t n, char c);iterator insert (const_iterator p, size_t n, char c); iterator insert (const_iterator p, char c); template <class InputIterator>iterator insert (iterator p, InputIterator first, InputIterator last); string& insert (const_iterator p, initializer_list<char> il);

// Inserts a copy of src into dest at position pos
void insert(char dest[MAX_STRING_DISK_SIZE], size_t pos, const char src[MAX_STRING_DISK_SIZE]) {
    size_t dest_length = length(dest);
    size_t src_length = length(src);
    assert(pos <= dest_length); // Ensure pos is within the destination string
    assert(dest_length + src_length < MAX_STRING_DISK_SIZE); // Ensure the combined length fits in the destination

    // Move the part of dest after pos to make room for src
    for (size_t i = dest_length; i >= pos; --i) {
        dest[i + src_length] = dest[i];
    }

    // Copy src into dest at position pos
    for (size_t i = 0; i < src_length; ++i) {
        dest[pos + i] = src[i];
    }

    // Ensure the destination string is null-terminated
    dest[dest_length + src_length] = '\0';
}


// Inserts a copy of the substring of src into dest at position pos
void insert(char dest[MAX_STRING_DISK_SIZE], size_t pos, const char src[MAX_STRING_DISK_SIZE], size_t subpos, size_t sublen) {
    size_t dest_length = length(dest);
    size_t src_length = length(src);
    assert(subpos <= src_length); // Ensure subpos is within the source string
    assert(pos <= dest_length); // Ensure pos is within the destination string

    // Adjust sublen if it exceeds the length of src or if it is NPOS
    if (sublen == NPOS || subpos + sublen > src_length) {
        sublen = src_length - subpos;
    }

    assert(dest_length + sublen < MAX_STRING_DISK_SIZE); // Ensure the combined length fits in the destination

    // Move the part of dest after pos to make room for the substring
    for (size_t i = dest_length; i >= pos; --i) {
        dest[i + sublen] = dest[i];
    }

    // Copy the substring from src into dest at position pos
    for (size_t i = 0; i < sublen; ++i) {
        dest[pos + i] = src[subpos + i];
    }

    // Ensure the destination string is null-terminated
    dest[dest_length + sublen] = '\0';
}



// Inserts a copy of the first n characters of src into dest at pos.
void insert(char dest[MAX_STRING_DISK_SIZE], size_t pos, const char src[MAX_STRING_DISK_SIZE], size_t sublen) {
    size_t dest_length = length(dest);
    size_t src_length = length(src);
    assert(pos <= dest_length); // Ensure pos is within the destination string
    assert(sublen <= src_length); // Ensure sublen is within the source string

    assert(dest_length + sublen < MAX_STRING_DISK_SIZE); // Ensure the combined length fits in the destination

    // Move the part of dest after pos to make room for the substring
    for (size_t i = dest_length; i >= pos; --i) {
        dest[i + sublen] = dest[i];
    }

    // Copy the substring from src into dest at position pos
    for (size_t i = 0; i < sublen; ++i) {
        dest[pos + i] = src[i];
    }

    // Ensure the destination string is null-terminated
    dest[dest_length + sublen] = '\0';
}



// Inserts n copies of c into dest starting at pos
void insert(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t n, char c) {
    size_t dest_length = length(dest);
    assert(pos <= dest_length); // Ensure pos is within the destination string
    assert(dest_length + n < MAX_STRING_DISK_SIZE); // Ensure the combined length fits in the destination

    // Move the part of dest after pos to make room for n copies of c
    for (size_t i = dest_length; i >= pos; --i) {
        dest[i + n] = dest[i];
    }

    // Insert n copies of c into dest at position pos
    for (size_t i = 0; i < n; ++i) {
        dest[pos + i] = c;
    }

    // Ensure the destination string is null-terminated
    dest[dest_length + n] = '\0';
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// Erases len characters starting at pos from str
// Note C++ uses default values
void erase(char str[MAX_STRING_DISK_SIZE], size_t pos, size_t len) {
    size_t str_length = length(str);
    assert(pos <= str_length); // Ensure pos is within the string

    // Adjust len if it exceeds the length of the string or if it is NPOS
    if (len == NPOS || pos + len > str_length) {
        len = str_length - pos;
    }

    // Move the part of the string after pos + len to pos
    for (size_t i = pos; i < str_length - len; ++i) {
        str[i] = str[i + len];
    }

    // Null-terminate the string at the new length
    for (size_t i = str_length - len; i < str_length; ++i) {
        str[i] = '\0';
    }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Note: check reference for a couple replaces that are missing.


// Replace len characters starting at pos with the string src
void replace(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t len, const char src[MAX_STRING_DISK_SIZE]) {
    size_t dest_length = length(dest);
    size_t src_length = length(src);
    assert(pos <= dest_length); // Ensure pos is within the string
    assert(pos + len <= src_length); // Ensure the replacement doesn't exceed src

    // Adjust len if it exceeds the length of the destination string
    if (len == NPOS || pos + len > dest_length) {
        len = dest_length - pos;
    }

    // Replace characters in dest with characters from src
    for (size_t i = 0; i < len; ++i) {
        dest[pos + i] = src[pos + i];
    }
}


// Copies the portion of src that begins at the character position subpos and spans sublen characters (or until the end of str, if either str is too short or if sublen is string::npos).
void replace(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t len, const char src[MAX_STRING_DISK_SIZE], size_t subpos, size_t sublen) {
    size_t dest_length = length(dest);
    size_t src_length = length(src);
    assert(pos <= dest_length); // Ensure pos is within the string
    assert(subpos <= src_length); // Ensure subpos is within the source string

    // Adjust sublen if it exceeds the length of src or if it is NPOS
    if (sublen == NPOS || subpos + sublen > src_length) {
        sublen = src_length - subpos;
    }

    // Adjust len if it exceeds the length of the destination string
    if (len == NPOS || pos + len > dest_length) {
        len = dest_length - pos;
    }

    // Replace characters in dest with characters from src
    for (size_t i = 0; i < sublen && i < len; ++i) {
        dest[pos + i] = src[subpos + i];
    }

    // Ensure the destination string is null-terminated if needed
    if (pos + sublen < dest_length) {
        dest[pos + sublen] = '\0';
    }
}



// Copies first len or sublen characters from first index of src into dest
void replace(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t len, const char src[MAX_STRING_DISK_SIZE], size_t sublen) {
    size_t dest_length = length(dest);
    size_t src_length = length(src);
    assert(pos <= dest_length); // Ensure pos is within the string

    // Adjust sublen if it exceeds the length of src or if it is NPOS
    if (sublen == NPOS || sublen > src_length) {
        sublen = src_length;
    }

    // Adjust len if it exceeds the length of the destination string
    if (len == NPOS || pos + len > dest_length) {
        len = dest_length - pos;
    }

    // Replace characters in dest with characters from src
    for (size_t i = 0; i < sublen && i < len; ++i) {
        dest[pos + i] = src[i];
    }

    // Ensure the destination string is null-terminated if needed
    if (pos + sublen < dest_length) {
        dest[pos + sublen] = '\0';
    }
}



// Replaces the portion of the str by n consecutive copies of character c.
void replace(char dest[MAX_STRING_DISK_SIZE], size_t pos, size_t len, char c) {
    size_t dest_length = length(dest);
    assert(pos <= dest_length); // Ensure pos is within the string

    // Adjust len if it exceeds the length of the destination string
    if (len == NPOS || pos + len > dest_length) {
        len = dest_length - pos;
    }

    // Replace characters in dest with n copies of character c
    for (size_t i = 0; i < len; ++i) {
        dest[pos + i] = c;
    }

    // Ensure the destination string is null-terminated if needed
    if (pos + len < dest_length) {
        dest[pos + len] = '\0';
    }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Swaps the character arrays
void swap(char swap1[MAX_STRING_DISK_SIZE], char swap2[MAX_STRING_DISK_SIZE]) {
    char temp[MAX_STRING_DISK_SIZE];

    // Copy swap1 to temp
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        temp[i] = swap1[i];
    }

    // Copy swap2 to swap1
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        swap1[i] = swap2[i];
    }

    // Copy temp to swap2
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        swap2[i] = temp[i];
    }
}



// Erases the last character of str
void pop_back(char str[MAX_STRING_DISK_SIZE]) {
    size_t len = length(str);
    if (len > 0) {
        str[len - 1] = '\0'; // Remove the last character by setting it to null terminator
    }
}
