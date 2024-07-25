## Implementing String functions in Metal for use on GPU
This is the C++ String class functions implemented in Metal (MSL).

### Definitions:

#### Type Conversion:
```int stoi(const char str[])```  

```long stol(const char str[])```  

```unsigned int stoul(const char str[])```  

```float stof(const char str[])```  

#### Capacity:
```size_t length(const char str[])```  

```size_t size(const char str[])```  

```size_t max_size(const char str[])```

```void clear(char str[])```  

```bool empty(char str[])```  

#### Element access:
```char at(const char str[], size_t pos)```  

```char back(const char str[])```  

```char front(const char str[])```  

#### Modifiers:
```void append(char dest[], const char src[])```  

```void push_back(char str[], char c)```  

```void assign(char dest[], const char src[])```  

```void assign(char dest[], const char src[], size_t subpos, size_t sublen)```  

```void assign(char dest[], const char src[], size_t sublen)```  

```void assign(char str[], size_t n, char c)```  

```void insert(char dest[], size_t pos, const char src[])```  

```void insert(char dest[], size_t pos, const char src[], size_t subpos, size_t sublen)```  

```void insert(char dest[], size_t pos, const char src[], size_t sublen)```  

```void insert(char dest[], size_t pos, size_t n, const char src[], size_t sublen)```  

```void erase(char str[], size_t pos, size_t len)```  

```void replace(char dest[], size_t pos, size_t len, const char src[])```  

```void replace(char dest[], size_t pos, size_t len, const char src[], size_t subpos, size_t sublen)```  

```void replace(char dest[], size_t pos, size_t len, const char src[], size_t sublen)```  

```void replace(char dest[], size_t pos, size_t len, char c)```  

```void swap(char swap1[], char swap2[])```  

```void pop_back(char str[])```  

#### String operations:
```void copy(char dest[], const char src[], size_t len, size_t pos)```  

```size_t find(const char full_str[], const char search_substr[])```  

```size_t find(const char full_str[], const char search_substr[], size_t pos)```  

```size_t find(const char str[], char c)```  

```size_t find(const char str[], char c, size_t pos)```  

```size_t rfind(const char full_str[], const char search_substr[])```  

```size_t rfind(const char full_str[], const char search_substr[], size_t pos)```  

```size_t rfind(const char str[], char c)```  

```size_t rfind(const char str[], char c, size_t pos)```  

```size_t find_first_of (const char str[], const char chars[])```  

```size_t find_first_of (const char str[], const char chars[], size_t pos)```  

```size_t find_first_of (const char str[], char c)```  

```size_t find_first_of (const char str[], char c, size_t pos)```  

```size_t find_last_of(const char str[], const char chars[])```  

```size_t find_last_of(const char str[], const char chars[], size_t pos)```  

```size_t find_last_of(const char str[], char c)```  

```size_t find_last_of(const char str[], char c, size_t pos)```  

```size_t find_first_not_of(const char str[], const char chars[])```  

```size_t find_first_not_of(const char str[], const char chars[], size_t pos)```  

```size_t find_first_not_of(const char str[], const char c)```  

```size_t find_first_not_of(const char str[], const char c, size_t pos)```  

```size_t find_last_not_of(const char str[], const char chars[])```  

```size_t find_last_not_of(const char str[], const char chars[], size_t pos)```  

```size_t find_last_not_of(const char str[], char c)```  

```size_t find_last_not_of(const char str[], char c, size_t pos)```  

```void substr(char dest[], const char src[], size_t pos, size_t len)```  

```int compare(const char str[], const char compare_str[])```  

```int compare(const char str[], size_t compare_str_pos, size_t compare_str_len, const char compare_str[])``` 

### References  
https://cplusplus.com/reference/string/string/  
https://developer.apple.com/metal/
