## Implementing String functions in Metal for use on GPU

### Definitions:
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
void append(char first[MAX_STRING_DISK_SIZE], const char second[MAX_STRING_DISK_SIZE]);  
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

### Reference  
https://cplusplus.com/reference/string/string/