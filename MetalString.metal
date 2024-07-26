// String class on GPU using Metal
// uses C++ string class as reference https://cplusplus.com/reference/string/string/
// Created by Tyler Hilbert, TYHSoftware@gmail.com      July 2024

#ifndef METAL_STRING_METAL
#define METAL_STRING_METAL

#include <metal_stdlib>

#define MAX_STRING_SIZE 100
#define MAX_STRING_DISK_SIZE (MAX_STRING_SIZE + 1) // For null terminator

using namespace metal;


class MetalString {
    
static constant size_t NPOS = -1;
    
public:
    MetalString();
    MetalString(const thread char (&init_str)[MAX_STRING_DISK_SIZE]);

    int stoi() const;
    long stol() const;
    unsigned int stoul() const;
    float stof() const;

    size_t length() const;
    size_t size() const;
    size_t max_size() const;
    //// To implement       void resize (size_t n);void resize (size_t n, char c);
    //// To implement       size_t capacity();
    //// To implement       void reserve (size_t n = 0);
    void clear();
    bool empty() const;
    //// To implement       void shrink_to_fit();

    //// To implement        char& operator[] (size_t pos);const char& operator[] (size_t pos) const;
    // Note these return constants rather than C++ which returns references
    char at(size_t pos) const;
    char back() const;
    char front() const;

    //// To implement       string& operator+= (const string& str); string& operator+= (const char* s); string& operator+= (char c); string& operator+= (initializer_list<char> il);
    void append(thread const MetalString& src);
    void push_back(char c);
    void assign(thread const MetalString& src);
    void assign(thread const MetalString& src, size_t subpos, size_t sublen);
    void assign(thread const MetalString& src, size_t sublen);
    void assign(size_t n, char c);
    void insert(size_t pos, thread const MetalString& src);
    void insert(size_t pos, thread const MetalString& src, size_t subpos, size_t sublen);
    void insert(size_t pos, thread const MetalString& src, size_t sublen);
    void insert(size_t pos, size_t n, char c);
    void erase(size_t pos, size_t len);
    void replace(size_t pos, size_t len, thread const MetalString& src);
    void replace(size_t pos, size_t len, thread const MetalString& src, size_t subpos, size_t sublen);
    void replace(size_t pos, size_t len, thread const MetalString& src, size_t sublen);
    void replace(size_t pos, size_t len, char c);
    void swap(thread MetalString& other);
    void pop_back();

    //// To implement       const char* c_str() const noexcept;
    //// To implement       const char* data() const noexcept;
    //// To implement       allocator_type get_allocator() const noexcept;
    void copy(thread const MetalString& src, size_t len, size_t pos);
    size_t find(thread const MetalString& search_substr) const;
    size_t find(thread const MetalString& search_substr, size_t pos) const;
    size_t find(char c) const;
    size_t find(char c, size_t pos) const;
    size_t rfind(thread const MetalString& search_substr) const;
    size_t rfind(thread const MetalString& search_substr, size_t pos) const;
    size_t rfind(char c) const;
    size_t rfind(char c, size_t pos) const;
    size_t find_first_of(thread const MetalString& chars) const;
    size_t find_first_of(thread const MetalString& chars, size_t pos) const;
    size_t find_first_of(char c) const;
    size_t find_first_of(char c, size_t pos) const;
    size_t find_last_of(thread const MetalString& chars) const;
    size_t find_last_of(thread const MetalString& chars, size_t pos) const;
    size_t find_last_of(char c) const;
    size_t find_last_of(char c, size_t pos) const;
    size_t find_first_not_of(thread const MetalString& chars) const;
    size_t find_first_not_of(thread const MetalString& chars, size_t pos) const;
    size_t find_first_not_of(char c) const;
    size_t find_first_not_of(char c, size_t pos) const;
    size_t find_last_not_of(thread const MetalString& chars) const;
    size_t find_last_not_of(thread const MetalString& chars, size_t pos) const;
    size_t find_last_not_of(char c) const;
    size_t find_last_not_of(char c, size_t pos) const;
    void substr(thread MetalString& dest, size_t pos, size_t len) const;
    int compare(thread const MetalString& compare_str) const;
    int compare(size_t compare_str_pos, size_t compare_str_len, thread const MetalString& compare_str) const;

private:
    char str[MAX_STRING_DISK_SIZE];
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MetalString::MetalString() {
    clear();
}

MetalString::MetalString(const thread char (&init_str)[MAX_STRING_DISK_SIZE]) {
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        str[i] = init_str[i];
        if (init_str[i] == '\0') {
            break;
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Convert string to int
int MetalString::stoi() const {
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
long MetalString::stol() const {
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
unsigned int MetalString::stoul() const {
    unsigned int res = 0;
    int i = 0;

    for (; str[i] != '\0'; ++i)
        res = res * 10 + str[i] - '0';

    return res;
}

// Convert string to float
float MetalString::stof() const {
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
size_t MetalString::length() const {
    size_t len = 0;
    while (str[len] != '\0') {
        len++;
    }
    return len;
}

// Function to calculate the size of the string, using the length() function
size_t MetalString::size() const {
    return length();
}

// Function to return the maximum size of the string not including null terminator
size_t MetalString::max_size() const {
    return MAX_STRING_SIZE;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Function to clear the contents of the string
void MetalString::clear() {
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        str[i] = '\0';
    }
}

// Function to check if the string is empty
bool MetalString::empty() const {
    return str[0] == '\0';
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Returns character at position pos
// Note C++ returns reference usually
char MetalString::at(size_t pos) const {
    assert(pos < MAX_STRING_DISK_SIZE);
    return str[pos];
}

// Returns last character
// Note C++ returns reference usually
char MetalString::back() const {
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
char MetalString::front() const {
    assert(!empty()); // Ensure the string is not empty
    return str[0];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Note C++ has different: string& append (const string& str); string& append (const string& str, size_t subpos, size_t sublen = npos); string& append (const char* s); string& append (const char* s, size_t n); string& append (size_t n, char c); template <class InputIterator>   string& append (InputIterator first, InputIterator last); string& append (initializer_list<char> il);
// Function to append one string to another
void MetalString::append(thread const MetalString& src) {
    size_t dest_length = length();
    size_t src_length = src.length();
    assert(dest_length + src_length < MAX_STRING_DISK_SIZE); // Ensure enough space

    for (size_t i = 0; i < src_length; ++i) {
        str[dest_length + i] = src.str[i];
    }
    str[dest_length + src_length] = '\0';
}

// Function to append a character to the end of the string
void MetalString::push_back(char c) {
    size_t len = length();
    assert(len < MAX_STRING_SIZE); // Ensure there is space to add another character
    str[len] = c;
    str[len + 1] = '\0'; // Add null terminator
}

// Assign the contents of one char array to another
void MetalString::assign(thread const MetalString& src) {
    // Copy the source string to str
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        str[i] = src.str[i];
    }
}

// Copies the portion of src that begins at the character position subpos and spans sublen characters (or until the end of src, if either src is too short or if sublen is npos).
void MetalString::assign(thread const MetalString& src, size_t subpos, size_t sublen) {
    size_t src_length = src.length();
    assert(subpos <= src_length); // Ensure subpos is within the source string

    if (sublen == NPOS || subpos + sublen > src_length) { // TODO -- verify npos is correct
        sublen = src_length - subpos; // Adjust sublen if it exceeds the source string length
    }

    assert(subpos + sublen < MAX_STRING_DISK_SIZE); // Ensure the substring fits in str

    // Clear str
    clear();

    // Copy the substring from the source string to str
    for (size_t i = 0; i < sublen; ++i) {
        str[i] = src.str[subpos + i];
    }
    str[sublen] = '\0';
}

// Assign the first n characters from src to str
void MetalString::assign(thread const MetalString& src, size_t sublen) {
    assign(src, 0, sublen);
}

// Fill str with n consecutive copies of character c.
void MetalString::assign(size_t n, char c) {
    assert(n < MAX_STRING_DISK_SIZE); // Ensure n does not exceed the maximum size

    // Clear str
    clear();

    // Fill str with n copies of character c
    for (size_t i = 0; i < n; ++i) {
        str[i] = c;
    }
    str[n] = '\0'; // Add null terminator
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Note C++ has different:string& insert (size_t pos, const string& str); string& insert (size_t pos, const string& str, size_t subpos, size_t sublen = npos); string& insert (size_t pos, const char* s); string& insert (size_t pos, const char* s, size_t n); string& insert (size_t pos,   size_t n, char c);iterator insert (const_iterator p, size_t n, char c); iterator insert (const_iterator p, char c); template <class InputIterator>iterator insert (iterator p, InputIterator first, InputIterator last); string& insert (const_iterator p, initializer_list<char> il);

// Inserts a copy of src into str at position pos
void MetalString::insert(size_t pos, thread const MetalString& src) {
    size_t dest_length = length();
    size_t src_length = src.length();
    assert(pos <= dest_length); // Ensure pos is within str
    assert(dest_length + src_length < MAX_STRING_DISK_SIZE); // Ensure the combined length fits in str

    // Move the part of str after pos to make room for src
    for (size_t i = dest_length; i >= pos; --i) {
        str[i + src_length] = str[i];
    }

    // Copy src into str at position pos
    for (size_t i = 0; i < src_length; ++i) {
        str[pos + i] = src.str[i];
    }

    // Ensure str is null-terminated
    str[dest_length + src_length] = '\0';
}

// Inserts a copy of the substring of src into str at position pos
void MetalString::insert(size_t pos, thread const MetalString& src, size_t subpos, size_t sublen) {
    size_t dest_length = length();
    size_t src_length = src.length();
    assert(subpos <= src_length); // Ensure subpos is within the source string
    assert(pos <= dest_length); // Ensure pos is within str

    // Adjust sublen if it exceeds the length of src or if it is NPOS
    if (sublen == NPOS || subpos + sublen > src_length) {
        sublen = src_length - subpos;
    }

    assert(dest_length + sublen < MAX_STRING_DISK_SIZE); // Ensure the combined length fits in str

    // Move the part of str after pos to make room for the substring
    for (size_t i = dest_length; i >= pos; --i) {
        str[i + sublen] = str[i];
    }

    // Copy the substring from src into str at position pos
    for (size_t i = 0; i < sublen; ++i) {
        str[pos + i] = src.str[subpos + i];
    }

    // Ensure str is null-terminated
    str[dest_length + sublen] = '\0';
}

// Inserts a copy of the first n characters of src into str at pos.
void MetalString::insert(size_t pos, thread const MetalString& src, size_t sublen) {
    size_t dest_length = length();
    assert(pos <= dest_length); // Ensure pos is within str
    assert(sublen <= src.length()); // Ensure sublen is within the source string

    assert(dest_length + sublen < MAX_STRING_DISK_SIZE); // Ensure the combined length fits in str

    // Move the part of str after pos to make room for the substring
    for (size_t i = dest_length; i >= pos; --i) {
        str[i + sublen] = str[i];
    }

    // Copy the substring from src into str at position pos
    for (size_t i = 0; i < sublen; ++i) {
        str[pos + i] = src.str[i];
    }

    // Ensure str is null-terminated
    str[dest_length + sublen] = '\0';
}

// Inserts n copies of c into str starting at pos
void MetalString::insert(size_t pos, size_t n, char c) {
    size_t dest_length = length();
    assert(pos <= dest_length); // Ensure pos is within str
    assert(dest_length + n < MAX_STRING_DISK_SIZE); // Ensure the combined length fits in str

    // Move the part of str after pos to make room for n copies of c
    for (size_t i = dest_length; i >= pos; --i) {
        str[i + n] = str[i];
    }

    // Insert n copies of c into str at position pos
    for (size_t i = 0; i < n; ++i) {
        str[pos + i] = c;
    }

    // Ensure str is null-terminated
    str[dest_length + n] = '\0';
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Erases len characters starting at pos from str
// Note C++ uses default values
void MetalString::erase(size_t pos, size_t len) {
    size_t str_length = length();
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
void MetalString::replace(size_t pos, size_t len, thread const MetalString& src) {
    size_t dest_length = length();
    assert(pos <= dest_length); // Ensure pos is within str
    assert(pos + len <= src.length()); // Ensure the replacement doesn't exceed src

    // Adjust len if it exceeds the length of str
    if (len == NPOS || pos + len > dest_length) {
        len = dest_length - pos;
    }

    // Replace characters in str with characters from src
    for (size_t i = 0; i < len; ++i) {
        str[pos + i] = src.str[pos + i];
    }
}

// Copies the portion of src that begins at the character position subpos and spans sublen characters (or until the end of str, if either str is too short or if sublen is string::npos).
void MetalString::replace(size_t pos, size_t len, thread const MetalString& src, size_t subpos, size_t sublen) {
    size_t dest_length = length();
    size_t src_length = src.length();
    assert(pos <= dest_length); // Ensure pos is within str
    assert(subpos <= src_length); // Ensure subpos is within the source string

    // Adjust sublen if it exceeds the length of src or if it is NPOS
    if (sublen == NPOS || subpos + sublen > src_length) {
        sublen = src_length - subpos;
    }

    // Adjust len if it exceeds the length of str
    if (len == NPOS || pos + len > dest_length) {
        len = dest_length - pos;
    }

    // Replace characters in str with characters from src
    for (size_t i = 0; i < sublen && i < len; ++i) {
        str[pos + i] = src.str[subpos + i];
    }

    // Ensure str is null-terminated if needed
    if (pos + sublen < dest_length) {
        str[pos + sublen] = '\0';
    }
}

// Copies first len or sublen characters from first index of src into str
void MetalString::replace(size_t pos, size_t len, thread const MetalString& src, size_t sublen) {
    size_t dest_length = length();
    size_t src_length = src.length();
    assert(pos <= dest_length); // Ensure pos is within str

    // Adjust sublen if it exceeds the length of src or if it is NPOS
    if (sublen == NPOS || sublen > src_length) {
        sublen = src_length;
    }

    // Adjust len if it exceeds the length of str
    if (len == NPOS || pos + len > dest_length) {
        len = dest_length - pos;
    }

    // Replace characters in str with characters from src
    for (size_t i = 0; i < sublen && i < len; ++i) {
        str[pos + i] = src.str[i];
    }

    // Ensure str is null-terminated if needed
    if (pos + sublen < dest_length) {
        str[pos + sublen] = '\0';
    }
}

// Replaces the portion of str by n consecutive copies of character c.
void MetalString::replace(size_t pos, size_t len, char c) {
    size_t dest_length = length();
    assert(pos <= dest_length); // Ensure pos is within str

    // Adjust len if it exceeds the length of str
    if (len == NPOS || pos + len > dest_length) {
        len = dest_length - pos;
    }

    // Replace characters in str with n copies of character c
    for (size_t i = 0; i < len; ++i) {
        str[pos + i] = c;
    }

    // Ensure str is null-terminated if needed
    if (pos + len < dest_length) {
        str[pos + len] = '\0';
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Swaps the character arrays
void MetalString::swap(thread MetalString& other) {
    char temp[MAX_STRING_DISK_SIZE];

    // Copy str to temp
    for (size_t i = 0; i < MAX_STRING_DISK_SIZE; ++i) {
        temp[i] = str[i];
        str[i] = other.str[i];
        other.str[i] = temp[i];
    }
}

// Erases the last character of str
void MetalString::pop_back() {
    size_t len = length();
    if (len > 0) {
        str[len - 1] = '\0'; // Remove the last character by setting it to null terminator
    }
}

// Copy sequence of characters from src to str
void MetalString::copy(thread const MetalString& src, size_t len, size_t pos) {
    size_t src_length = src.length();
    assert(pos <= src_length); // Ensure pos is within src

    // Adjust len if it exceeds the length of src
    if (pos + len > src_length) {
        len = src_length - pos;
    }

    // Copy characters from src to str
    for (size_t i = 0; i < len; ++i) {
        str[i] = src.str[pos + i];
    }
    // Null-terminate the destination string if needed
    if (len < MAX_STRING_DISK_SIZE) {
        str[len] = '\0';
    }
}

// Searches for search_substr in str
size_t MetalString::find(thread const MetalString& search_substr) const {
    return find(search_substr, 0);
}

// Searches for search_substr in str starting at index pos
size_t MetalString::find(thread const MetalString& search_substr, size_t pos) const {
    size_t full_str_length = length();
    size_t search_substr_length = search_substr.length();

    if (pos > full_str_length) {
        return NPOS; // If pos is greater than the length of str, return NPOS
    }

    for (size_t i = pos; i <= full_str_length - search_substr_length; ++i) {
        bool match = true;
        for (size_t j = 0; j < search_substr_length; ++j) {
            if (str[i + j] != search_substr.str[j]) {
                match = false;
                break;
            }
        }
        if (match) {
            return i; // Return the position of the first match
        }
    }

    return NPOS; // No match found
}

// Searches for c in str
size_t MetalString::find(char c) const {
    return find(c, 0);
}

// Searches for c in str starting at index pos
size_t MetalString::find(char c, size_t pos) const {
    size_t str_length = length();

    // If pos is greater than the length of str, return NPOS
    if (pos >= str_length) {
        return NPOS;
    }

    // Iterate through str starting at pos
    for (size_t i = pos; i < str_length; ++i) {
        if (str[i] == c) {
            return i; // Return the position of the first occurrence of c
        }
    }

    return NPOS; // No match found
}

// Searches for last occurrence of search_substr in str
size_t MetalString::rfind(thread const MetalString& search_substr) const {
    return rfind(search_substr, 0);
}

// Searches for last occurrence of search_substr in str starting at index pos
size_t MetalString::rfind(thread const MetalString& search_substr, size_t pos) const {
    size_t full_str_length = length();
    size_t search_substr_length = search_substr.length();

    // If pos is greater than or equal to the length of str, search the entire string
    if (pos >= full_str_length) {
        pos = full_str_length - 1;
    }

    // If the search_substr is longer than str or pos is invalid, return NPOS
    if (search_substr_length > full_str_length || pos == NPOS) {
        return NPOS;
    }

    for (size_t i = pos + 1; i >= search_substr_length; --i) {
        bool match = true;
        for (size_t j = 0; j < search_substr_length; ++j) {
            if (str[i - search_substr_length + j] != search_substr.str[j]) {
                match = false;
                break;
            }
        }
        if (match) {
            return i - search_substr_length;
        }
    }

    return NPOS; // No match found
}

// Searches for last occurrence of char c in str
size_t MetalString::rfind(char c) const {
    return rfind(c, 0);
}

// Searches for last occurrence of char c in str starting at index pos
size_t MetalString::rfind(char c, size_t pos) const {
    size_t str_length = length();

    // If pos is greater than the length of str, set pos to the last index
    if (pos >= str_length) {
        pos = str_length - 1;
    }

    // Iterate backwards through str starting at pos
    for (size_t i = pos + 1; i > 0; --i) {
        if (str[i - 1] == c) {
            return i - 1; // Return the position of the last occurrence of c
        }
    }

    return NPOS; // No match found
}

// Searches str for the first character that matches ANY of chars
size_t MetalString::find_first_of(thread const MetalString& chars) const {
    return find_first_of(chars, 0);
}

// Searches str for the first character that matches any of chars starting at str index pos
size_t MetalString::find_first_of(thread const MetalString& chars, size_t pos) const {
    size_t str_length = length();
    size_t chars_length = chars.length();

    // If pos is greater than the length of str, return NPOS
    if (pos >= str_length) {
        return NPOS;
    }

    // Iterate through str starting at pos
    for (size_t i = pos; i < str_length; ++i) {
        // Check if str[i] matches any character in chars
        for (size_t j = 0; j < chars_length; ++j) {
            if (str[i] == chars.str[j]) {
                return i; // Return the position of the first match
            }
        }
    }

    return NPOS; // No match found
}

// Searches for first instance of c in str
size_t MetalString::find_first_of(char c) const {
    return find_first_of(c, 0);
}

// Searches for first instance of c in str starting at index pos
size_t MetalString::find_first_of(char c, size_t pos) const {
    return find(c, pos);
}

// Searches str for the last character that matches any of the characters in chars starting at str index pos
size_t MetalString::find_last_of(thread const MetalString& chars) const {
    return find_last_of(chars, 0);
}

// Searches str for the last character that matches any of the characters in chars starting at str index pos
size_t MetalString::find_last_of(thread const MetalString& chars, size_t pos) const {
    size_t str_length = length();
    size_t chars_length = chars.length();

    // If pos is greater than or equal to the length of str, set pos to the last valid index
    if (pos >= str_length) {
        pos = str_length - 1;
    }

    // Iterate backwards through str starting at pos
    for (size_t i = pos + 1; i > 0; --i) {
        // Check if str[i-1] matches any character in chars
        for (size_t j = 0; j < chars_length; ++j) {
            if (str[i - 1] == chars.str[j]) {
                return i - 1; // Return the position of the last match
            }
        }
    }

    return NPOS; // No match found
}

// Searches str for the last character that matches character c starting at str index pos
size_t MetalString::find_last_of(char c) const {
    return find_last_of(c, 0);
}

// Searches str for the last character that matches character c starting at str index pos
size_t MetalString::find_last_of(char c, size_t pos) const {
    size_t str_length = length();

    // If pos is greater than or equal to the length of str, set pos to the last valid index
    if (pos >= str_length) {
        pos = str_length - 1;
    }

    // Iterate backwards through str starting at pos
    for (size_t i = pos + 1; i > 0; --i) {
        if (str[i - 1] == c) {
            return i - 1; // Return the position of the last match
        }
    }

    return NPOS; // No match found
}

// Searches str for the first character that does not match any of the characters in chars
size_t MetalString::find_first_not_of(thread const MetalString& chars) const {
    return find_first_not_of(chars, 0);
}

// Searches str for the first character that does not match any of the characters in chars starting at str index pos
size_t MetalString::find_first_not_of(thread const MetalString& chars, size_t pos) const {
    size_t str_length = length();
    size_t chars_length = chars.length();

    // If pos is greater than or equal to the length of str, return NPOS
    if (pos >= str_length) {
        return NPOS;
    }

    // Iterate through str starting at pos
    for (size_t i = pos; i < str_length; ++i) {
        bool match = false;
        // Check if str[i] matches any character in chars
        for (size_t j = 0; j < chars_length; ++j) {
            if (str[i] == chars.str[j]) {
                match = true;
                break;
            }
        }
        if (!match) {
            return i; // Return the position of the first character that does not match
        }
    }

    return NPOS; // No such character found
}

// Searches str for first character that isn't c
size_t MetalString::find_first_not_of(char c) const {
    return find_first_not_of(c, 0);
}

// Searches str for first character that isn't c starting at index pos
size_t MetalString::find_first_not_of(char c, size_t pos) const {
    size_t str_length = length();

    // If pos is greater than or equal to the length of str, return NPOS
    if (pos >= str_length) {
        return NPOS;
    }

    // Iterate through str starting at pos
    for (size_t i = pos; i < str_length; ++i) {
        if (str[i] != c) {
            return i; // Return the position of the first character that is not c
        }
    }

    return NPOS; // No such character found
}

// Searches str for the last character that does not match any of the characters in chars starting at str index pos
size_t MetalString::find_last_not_of(thread const MetalString& chars) const {
    return find_last_not_of(chars, 0);
}

// Searches str for the last character that does not match any of the characters in chars starting at str index pos
size_t MetalString::find_last_not_of(thread const MetalString& chars, size_t pos) const {
    size_t str_length = length();
    size_t chars_length = chars.length();

    // If pos is greater than or equal to the length of str, set pos to the last valid index
    if (pos >= str_length) {
        pos = str_length - 1;
    }

    // Iterate backwards through str starting at pos
    for (size_t i = pos + 1; i > 0; --i) {
        bool match = false;
        // Check if str[i-1] matches any character in chars
        for (size_t j = 0; j < chars_length; ++j) {
            if (str[i - 1] == chars.str[j]) {
                match = true;
                break;
            }
        }
        if (!match) {
            return i - 1; // Return the position of the last character that does not match
        }
    }

    return NPOS; // No such character found
}

// Searches str for the last character that isn't character c
size_t MetalString::find_last_not_of(char c) const {
    return find_last_not_of(c, 0);
}

// Searches str for the last character that isn't character c starting at str index pos
size_t MetalString::find_last_not_of(char c, size_t pos) const {
    size_t str_length = length();

    // If pos is greater than or equal to the length of str, set pos to the last valid index
    if (pos >= str_length) {
        pos = str_length - 1;
    }

    // Iterate backwards through str starting at pos
    for (size_t i = pos + 1; i > 0; --i) {
        if (str[i - 1] != c) {
            return i - 1; // Return the position of the last character that is not c
        }
    }

    return NPOS; // No such character found
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Creates substring of src in dest starting at pos of length len
// Note: Didn't implement all permutations of the optional arguments
void MetalString::substr(thread MetalString& dest, size_t pos, size_t len) const {
    size_t src_length = length();

    // If pos is greater than or equal to the length of src, set dest to an empty string
    if (pos >= src_length) {
        dest.clear();
        return;
    }

    // Adjust len if it exceeds the length of the source string
    if (len == NPOS || pos + len > src_length) {
        len = src_length - pos;
    }

    // Copy the substring from src to dest
    for (size_t i = 0; i < len; ++i) {
        dest.str[i] = str[pos + i];
    }

    // Null-terminate the destination string
    dest.str[len] = '\0';
}

// Compares str to compare_str
// 0 they are equal
// <0 Either the value of the first character that does not match is lower in the compared string, or all compared characters match but the compared string is shorter.
// >0 Either the value of the first character that does not match is greater in the compared string, or all compared characters match but the compared string is longer.
int MetalString::compare(thread const MetalString& compare_str) const {
    size_t len1 = length();
    size_t len2 = compare_str.length();
    size_t min_len = (len1 < len2) ? len1 : len2;

    // Compare characters of both strings up to the length of the shorter string
    for (size_t i = 0; i < min_len; ++i) {
        if (str[i] != compare_str.str[i]) {
            return (str[i] < compare_str.str[i]) ? -1 : 1;
        }
    }

    // If all characters match, compare the lengths
    if (len1 == len2) {
        return 0;
    } else {
        return (len1 < len2) ? -1 : 1;
    }
}

// Compares str to substring of compare_str
// 0 they are equal
// <0 Either the value of the first character that does not match is lower in the compared string, or all compared characters match but the compared string is shorter.
// >0 Either the value of the first character that does not match is greater in the compared string, or all compared characters match but the compared string is longer.
int MetalString::compare(size_t compare_str_pos, size_t compare_str_len, thread const MetalString& compare_str) const {
    size_t str_len = length();
    size_t compare_str_length = compare_str.length();

    // Ensure compare_str_pos is within the length of compare_str
    assert(compare_str_pos <= compare_str_length);

    // Adjust compare_str_len if it exceeds the length of compare_str from compare_str_pos
    if (compare_str_pos + compare_str_len > compare_str_length) {
        compare_str_len = compare_str_length - compare_str_pos;
    }

    size_t min_len = (str_len < compare_str_len) ? str_len : compare_str_len;

    // Compare characters of str and the substring of compare_str
    for (size_t i = 0; i < min_len; ++i) {
        if (str[i] != compare_str.str[compare_str_pos + i]) {
            return (str[i] < compare_str.str[compare_str_pos + i]) ? -1 : 1;
        }
    }

    // If all characters match, compare the lengths
    if (str_len == compare_str_len) {
        return 0;
    } else {
        return (str_len < compare_str_len) ? -1 : 1;
    }
}

#endif // METAL_STRING_METAL
