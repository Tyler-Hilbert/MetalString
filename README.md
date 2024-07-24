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
void clear(char str[MAX_STRING_SIZE]);  
bool empty(const char str[MAX_STRING_SIZE]);  
//// To implement       void shrink_to_fit();  
